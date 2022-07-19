DecsOnD.SFDC.MetaDataCache = function(config) {
  var _self = this;
  _self.init(config);
};
DecsOnD.SFDC.MetaDataCache.prototype.init = function(config) {
  var _self = this;
  config = DecsOnD.mergeObjects({
    loadData: function(callback, err, params, cacheable) {}
  }, config);
  DecsOnD.initProps(_self, config);
};
DecsOnD.SFDC.MetaDataCache.TYPES = 'Types';
DecsOnD.SFDC.MetaDataCache.PICKLIST_ENTRIES = 'PicklistEntries';
DecsOnD.SFDC.MetaDataCache.RELATION = 'Relation';
DecsOnD.SFDC.MetaDataCache.ALL_TYPES = 'AllTypes';
DecsOnD.SFDC.MetaDataCache.FIELDS = 'Fields';
DecsOnD.SFDC.MetaDataCache.cached = {};
DecsOnD.SFDC.MetaDataCache.cacheFull = false;
DecsOnD.SFDC.MetaDataCache.get = function(type, keys, callback, action) {
  var hit = _containsAll(DecsOnD.SFDC.MetaDataCache.cached, keys, type, DecsOnD.SFDC.MetaDataCache.cacheFull);
  if (hit){
    callback(
      _buildCacheResponse(
        DecsOnD.SFDC.MetaDataCache.cached,
        type,
        keys,
        DecsOnD.SFDC.MetaDataCache.cacheFull));
  } else if( action ) {
    // console.warn('cache miss!');
    if (keys) action.setParams(_getRequestParam(keys, type));
    action.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        var value = response.getReturnValue();
        DecsOnD.SFDC.MetaDataCache.set(type, keys, value);

        callback.call(this,
          _buildCacheResponse(
            DecsOnD.SFDC.MetaDataCache.cached,
            type,
            keys,
            DecsOnD.SFDC.MetaDataCache.cacheFull));
      } else if (state === "ERROR") {
        console.warn('MetaDataCache callback failed.')
        callback({'Error': 'Server error'});
      }
    });
    $A.enqueueAction(action);
  } else {
    callback({'Error': 'cache miss and no action provided.'})
  }
}
DecsOnD.SFDC.MetaDataCache.set = function(type, keys, value) {

  var cached = DecsOnD.SFDC.MetaDataCache.cached || {}
  if (type === DecsOnD.SFDC.MetaDataCache.ALL_TYPES) {
    DecsOnD.SFDC.MetaDataCache.cacheFull = true;
    cached[DecsOnD.SFDC.MetaDataCache.ALL_TYPES] = value;
  } else {
    if (!cached[type]) cached[type] = {};
    if (type === DecsOnD.SFDC.MetaDataCache.PICKLIST_ENTRIES) {
      var ret = {};
      ret[ Object.values(keys)[0] ] = value;
      cached[type][Object.keys(keys)[0]] = ret;
    } else {
      Object.keys(value).map(function(i) {
        cached[type][i] = value[i];
      })
    }
  }
}
/* Pure functions */
// check whether items are in cache, by type and key
function _containsAll(cache, keys, type, cacheFull) {
  var input = cache[type];

  switch(type){
    case DecsOnD.SFDC.MetaDataCache.PICKLIST_ENTRIES:
      return input !== undefined && input[Object.keys(keys)[0]] !== undefined && input[Object.keys(keys)[0]][Object.values(keys)[0]] !== undefined;
    case DecsOnD.SFDC.MetaDataCache.ALL_TYPES:
      return cacheFull;
    case DecsOnD.SFDC.MetaDataCache.TYPES:
      if (! cacheFull) {
        break;
      } else {
        return true;
      }
    default:
      if (input && keys) {
        var container = Object.keys(input);
        return keys.filter(function(i) {
          return container.indexOf(i) > -1;
        }).length === keys.length;
      }
  }
}
// builds request params based on action type
function _getRequestParam(params, type){
  switch(type){
    case DecsOnD.SFDC.MetaDataCache.PICKLIST_ENTRIES:
      var objectName = Object.keys(params)[0]; // TODO check for browser support for object.keys()
      return { objectName : objectName, pickListFieldName : params[objectName] };
    case DecsOnD.SFDC.MetaDataCache.ALL_TYPES:
      return params;
    default: // getFields, getRelations, getTypes
      return { typeNames: params };
  }
}
// builds cache response
function _buildCacheResponse(cache, type, keys, cacheFull){

  if (!cache) return;
  switch(type){
    case DecsOnD.SFDC.MetaDataCache.ALL_TYPES:
      if (!keys && cacheFull) {
        return cache[DecsOnD.SFDC.MetaDataCache.ALL_TYPES];
      } else if (!keys) {
        return;
      }
    case DecsOnD.SFDC.MetaDataCache.PICKLIST_ENTRIES:
      if (cache[type]){
        return cache[type][Object.keys(keys)[0]][Object.values(keys)[0]];
      } else {
        return;
      }
    case DecsOnD.SFDC.MetaDataCache.TYPES:
      var ret = {};
      if(cacheFull){// check first whether full cahe is available
        keys.forEach(function(i) {
          ret[i] = cache[DecsOnD.SFDC.MetaDataCache.ALL_TYPES][i];
        })
      } else { // then look into cache.TYPES
        keys.forEach(function(i) {
          ret[i] = cache[type][i];
        })
      }
      return ret;
    default:
      var ret = {};
      keys.forEach(function(i) {
        ret[i] = cache[type][i];
      })
      return ret;
  }
}
