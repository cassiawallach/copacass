/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class AssignToTerritoryAction implements DecsOnD.IBatchablePolicyAction2, DecsOnD.IPolicyAction {
    global static String ID_PARAMETER;
    global static String ROLE_IN_TERRITORY_PARAMETER;
    global static String TERRITORY_MODEL_PARAMETER;
    global static String TERRITORY_PARAMETER;
    global AssignToTerritoryAction() {

    }
    global virtual void addScopeToBatch(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void apply(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual DecsOnD.AssignToTerritoryAction.TerritoryScopeLoader createNoBatchScopeLoader(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual SObject createObjectTerritory2Association(SObject mainRec, String territoryName, SObject territoryModel) {
        return null;
    }
    global virtual DecsOnD.AssignToTerritoryAction.TerritoryScopeLoader createScopeLoader(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual SObject createUserTerritory2Association(User usr, String role, String territoryName, SObject territoryModel) {
        return null;
    }
    global static DecsOnD.AssignToTerritoryAction.TerritoryScopeLoader getCachedScopeLoader(DecsOnD.PolicyInvocationContext ctxt) {
        return null;
    }
    global String getLabel(String locale) {
        return null;
    }
    global String getName() {
        return null;
    }
    global virtual DecsOnD.AssignToTerritoryAction.TerritoryScopeLoader getScopeLoader(DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual void prepare(DecsOnD.PolicyActionRecord actionRec) {

    }
    global static void setCachedScopeLoader(DecsOnD.PolicyInvocationContext ctxt, DecsOnD.AssignToTerritoryAction.TerritoryScopeLoader loader) {

    }
global virtual class TerritoryScopeLoader implements DecsOnD.PolicyActionBatch.CustomScopeLoader {
    global TerritoryScopeLoader() {

    }
    global virtual void addTerritoryLoadRequest(String terrNameOrId) {

    }
    global virtual void addTerritoryModelLoadRequest(String modelNameOrId) {

    }
    global virtual void addToScope(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual void deleteExistingAssignments(DecsOnD.PolicyActionRecord actionRec) {

    }
    global virtual Map<Id,SObject> filterExistingAssignments(Map<Id,SObject> allAssignments, DecsOnD.PolicyActionRecord actionRec) {
        return null;
    }
    global virtual Set<String> getTerritoriesToLoad() {
        return null;
    }
    global virtual SObject getTerritory(String territoryName) {
        return null;
    }
    global virtual SObject getTerritory(String territoryName, String territoryModel) {
        return null;
    }
    global virtual SObject getTerritoryModel(String territoryModelName) {
        return null;
    }
    global virtual Set<String> getTerritoryModelsToLoad() {
        return null;
    }
    global virtual void loadScope(DecsOnD.PolicyActionBatch batch) {

    }
}
}
