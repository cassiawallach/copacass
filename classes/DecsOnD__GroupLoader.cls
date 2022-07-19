/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global virtual class GroupLoader {
    global static String OWNER_TYPE_GROUP;
    global static String OWNER_TYPE_PUBLIC_GROUP;
    global static String OWNER_TYPE_QUEUE;
    global static String OWNER_TYPE_ROLE;
    global static String OWNER_TYPE_USER;
    global GroupLoader() {

    }
    @Deprecated
    global static Set<String> addExtraUserFieldNames(Set<String> fieldNames) {
        return null;
    }
    global static void addGroupLoadRequest(String groupNameOrId) {

    }
    global static void addGroupLoadRequest(String groupType, String groupNameOrId) {

    }
    global static void addGroupMembersToCache(Id groupId, List<User> users) {

    }
    global static void addGroupToCache(Group grp) {

    }
    global static void addOwnerToCache(SObject owner, String ownerName) {

    }
    global static void addUserLoadRequest(String userNameOrId) {

    }
    global static void addUserToCache(User usr) {

    }
    global static void addUsersToCache(List<User> users) {

    }
    global virtual Map<String,Set<Id>> executeLoadRequests() {
        return null;
    }
    global static Set<Id> getCachedGroupIds() {
        return null;
    }
    global static Set<Id> getCachedUserIds() {
        return null;
    }
    global static Group getGroupFromCache(Id groupId) {
        return null;
    }
    global static Group getGroupFromCache(String groupType, String groupNameOrId) {
        return null;
    }
    global static Group getGroupFromCacheByName(String groupNameOrId) {
        return null;
    }
    global static List<User> getGroupMembersFromCache(Id groupId) {
        return null;
    }
    global static SObject getOwnerFromCache(Id ownerId) {
        return null;
    }
    global static SObject getOwnerFromCache(String ownerType, String ownerName) {
        return null;
    }
    global static String getOwnerType(SObject owner) {
        return null;
    }
    global static DecsOnD.GroupLoader getSingleton() {
        return null;
    }
    global static User getUserFromCache(String userNameOrId) {
        return null;
    }
    global static Boolean isCacheEmpty() {
        return null;
    }
    global static Boolean isGroupType(String ownerType) {
        return null;
    }
    global virtual Map<Id,List<User>> loadGroupMembers(Set<Id> groupIds, Boolean includeSubGroups) {
        return null;
    }
    global virtual Map<Id,GroupMember> queryGroupMembers(Set<Id> groupIds, Boolean includeSubGroups) {
        return null;
    }
    global Map<Id,Group> queryGroups(Set<Id> groupIds) {
        return null;
    }
    global Map<Id,Group> queryGroups(Set<String> groupNamesOrIds) {
        return null;
    }
    global Map<Id,Group> queryGroups(String groupType, Set<Id> groupIds) {
        return null;
    }
    global virtual Map<Id,Group> queryGroups(String groupType, Set<String> groupNamesOrIds) {
        return null;
    }
    global Map<Id,Group> queryPublicGroups(Set<Id> groupIds) {
        return null;
    }
    global Map<Id,Group> queryPublicGroups(Set<String> groupNamesOrIds) {
        return null;
    }
    global Map<Id,Group> queryQueues(Set<Id> groupIds) {
        return null;
    }
    global Map<Id,Group> queryQueues(Set<String> groupNamesOrIds) {
        return null;
    }
    global Map<Id,Group> queryRoleBasedGroups(Set<Id> groupIds) {
        return null;
    }
    global Map<Id,Group> queryRoleBasedGroups(Set<String> groupNamesOrIds) {
        return null;
    }
    global Map<Id,User> queryUsers(Set<Id> userIds) {
        return null;
    }
    global virtual Map<Id,User> queryUsers(Set<String> userNamesOrIds, Set<Id> roleIds) {
        return null;
    }
    @Deprecated
    global static void setExtraUserFieldNames(Set<String> fieldNames) {

    }
}
