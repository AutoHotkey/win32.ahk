#Requires AutoHotkey v2.1-alpha.37
#Include "..\_header.ahk"
#Import "..\Foundation\Types.ahk" {BOOL, FILETIME, HRESULT, PWSTR}
#Import "..\Networking.WinSock\Types.ahk" {SOCKADDR, SOCKADDR_IN6, SOCKADDR_STORAGE, SOCKET_ADDRESS, SOCKET_ADDRESS_LIST}
#Import "..\Security.Cryptography\Types.ahk" {CERT_PUBLIC_KEY_INFO}
#Import "..\System.Com\Types.ahk" {BLOB}

struct PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_VALUE extends UInt32 {
    static PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_1 := 1
    static PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_2 := 2
    static PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION := 2
}
struct PNRP_SCOPE extends Int32 {
    static PNRP_SCOPE_ANY := 0
    static PNRP_GLOBAL_SCOPE := 1
    static PNRP_SITE_LOCAL_SCOPE := 2
    static PNRP_LINK_LOCAL_SCOPE := 3
}
struct PNRP_CLOUD_STATE extends Int32 {
    static PNRP_CLOUD_STATE_VIRTUAL := 0
    static PNRP_CLOUD_STATE_SYNCHRONISING := 1
    static PNRP_CLOUD_STATE_ACTIVE := 2
    static PNRP_CLOUD_STATE_DEAD := 3
    static PNRP_CLOUD_STATE_DISABLED := 4
    static PNRP_CLOUD_STATE_NO_NET := 5
    static PNRP_CLOUD_STATE_ALONE := 6
}
struct PNRP_CLOUD_FLAGS extends Int32 {
    static PNRP_CLOUD_NO_FLAGS := 0
    static PNRP_CLOUD_NAME_LOCAL := 1
    static PNRP_CLOUD_RESOLVE_ONLY := 2
    static PNRP_CLOUD_FULL_PARTICIPANT := 4
}
struct PNRP_REGISTERED_ID_STATE extends Int32 {
    static PNRP_REGISTERED_ID_STATE_OK := 1
    static PNRP_REGISTERED_ID_STATE_PROBLEM := 2
}
struct PNRP_RESOLVE_CRITERIA extends Int32 {
    static PNRP_RESOLVE_CRITERIA_DEFAULT := 0
    static PNRP_RESOLVE_CRITERIA_REMOTE_PEER_NAME := 1
    static PNRP_RESOLVE_CRITERIA_NEAREST_REMOTE_PEER_NAME := 2
    static PNRP_RESOLVE_CRITERIA_NON_CURRENT_PROCESS_PEER_NAME := 3
    static PNRP_RESOLVE_CRITERIA_NEAREST_NON_CURRENT_PROCESS_PEER_NAME := 4
    static PNRP_RESOLVE_CRITERIA_ANY_PEER_NAME := 5
    static PNRP_RESOLVE_CRITERIA_NEAREST_PEER_NAME := 6
}
struct PNRP_CLOUD_ID {
    AddressFamily : Int32
    Scope : PNRP_SCOPE
    ScopeId : UInt32
}
struct PNRP_EXTENDED_PAYLOAD_TYPE extends Int32 {
    static PNRP_EXTENDED_PAYLOAD_TYPE_NONE := 0
    static PNRP_EXTENDED_PAYLOAD_TYPE_BINARY := 1
    static PNRP_EXTENDED_PAYLOAD_TYPE_STRING := 2
}
struct PNRPINFO_V1 {
    dwSize : UInt32
    lpwszIdentity : PWSTR
    nMaxResolve : UInt32
    dwTimeout : UInt32
    dwLifetime : UInt32
    enResolveCriteria : PNRP_RESOLVE_CRITERIA
    dwFlags : UInt32
    saHint : SOCKET_ADDRESS
    enNameState : PNRP_REGISTERED_ID_STATE
}
struct PNRPINFO_V2 {
    dwSize : UInt32
    lpwszIdentity : PWSTR
    nMaxResolve : UInt32
    dwTimeout : UInt32
    dwLifetime : UInt32
    enResolveCriteria : PNRP_RESOLVE_CRITERIA
    dwFlags : UInt32
    saHint : SOCKET_ADDRESS
    enNameState : PNRP_REGISTERED_ID_STATE
    enExtendedPayloadType : PNRP_EXTENDED_PAYLOAD_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            blobPayload : BLOB
            pwszPayload : PWSTR
        }
    }
}
struct PNRPCLOUDINFO {
    dwSize : UInt32
    Cloud : PNRP_CLOUD_ID
    enCloudState : PNRP_CLOUD_STATE
    enCloudFlags : PNRP_CLOUD_FLAGS
}
struct PEER_RECORD_CHANGE_TYPE extends Int32 {
    static PEER_RECORD_ADDED := 1
    static PEER_RECORD_UPDATED := 2
    static PEER_RECORD_DELETED := 3
    static PEER_RECORD_EXPIRED := 4
}
struct PEER_CONNECTION_STATUS extends Int32 {
    static PEER_CONNECTED := 1
    static PEER_DISCONNECTED := 2
    static PEER_CONNECTION_FAILED := 3
}
struct PEER_CONNECTION_FLAGS extends Int32 {
    static PEER_CONNECTION_NEIGHBOR := 1
    static PEER_CONNECTION_DIRECT := 2
}
struct PEER_RECORD_FLAGS extends Int32 {
    static PEER_RECORD_FLAG_AUTOREFRESH := 1
    static PEER_RECORD_FLAG_DELETED := 2
}
struct PEER_VERSION_DATA {
    wVersion : UInt16
    wHighestVersion : UInt16
}
struct PEER_DATA {
    cbData : UInt32
    pbData : UInt8.Ptr
}
struct PEER_RECORD {
    dwSize : UInt32
    type : GUID
    id : GUID
    dwVersion : UInt32
    dwFlags : UInt32
    pwzCreatorId : PWSTR
    pwzModifiedById : PWSTR
    pwzAttributes : PWSTR
    ftCreation : FILETIME
    ftExpiration : FILETIME
    ftLastModified : FILETIME
    securityData : PEER_DATA
    data : PEER_DATA
}
struct PEER_ADDRESS {
    dwSize : UInt32
    sin6 : SOCKADDR_IN6
}
struct PEER_CONNECTION_INFO {
    dwSize : UInt32
    dwFlags : UInt32
    ullConnectionId : Int64
    ullNodeId : Int64
    pwzPeerId : PWSTR
    address : PEER_ADDRESS
}
struct PEER_EVENT_INCOMING_DATA {
    dwSize : UInt32
    ullConnectionId : Int64
    type : GUID
    data : PEER_DATA
}
struct PEER_EVENT_RECORD_CHANGE_DATA {
    dwSize : UInt32
    changeType : PEER_RECORD_CHANGE_TYPE
    recordId : GUID
    recordType : GUID
}
struct PEER_EVENT_CONNECTION_CHANGE_DATA {
    dwSize : UInt32
    status : PEER_CONNECTION_STATUS
    ullConnectionId : Int64
    ullNodeId : Int64
    ullNextConnectionId : Int64
    hrConnectionFailedReason : HRESULT
}
struct PEER_EVENT_SYNCHRONIZED_DATA {
    dwSize : UInt32
    recordType : GUID
}
struct PEER_GRAPH_EVENT_TYPE extends Int32 {
    static PEER_GRAPH_EVENT_STATUS_CHANGED := 1
    static PEER_GRAPH_EVENT_PROPERTY_CHANGED := 2
    static PEER_GRAPH_EVENT_RECORD_CHANGED := 3
    static PEER_GRAPH_EVENT_DIRECT_CONNECTION := 4
    static PEER_GRAPH_EVENT_NEIGHBOR_CONNECTION := 5
    static PEER_GRAPH_EVENT_INCOMING_DATA := 6
    static PEER_GRAPH_EVENT_CONNECTION_REQUIRED := 7
    static PEER_GRAPH_EVENT_NODE_CHANGED := 8
    static PEER_GRAPH_EVENT_SYNCHRONIZED := 9
}
struct PEER_NODE_CHANGE_TYPE extends Int32 {
    static PEER_NODE_CHANGE_CONNECTED := 1
    static PEER_NODE_CHANGE_DISCONNECTED := 2
    static PEER_NODE_CHANGE_UPDATED := 3
}
struct PEER_GRAPH_STATUS_FLAGS extends Int32 {
    static PEER_GRAPH_STATUS_LISTENING := 1
    static PEER_GRAPH_STATUS_HAS_CONNECTIONS := 2
    static PEER_GRAPH_STATUS_SYNCHRONIZED := 4
}
struct PEER_GRAPH_PROPERTY_FLAGS extends Int32 {
    static PEER_GRAPH_PROPERTY_HEARTBEATS := 1
    static PEER_GRAPH_PROPERTY_DEFER_EXPIRATION := 2
}
struct PEER_GRAPH_SCOPE extends Int32 {
    static PEER_GRAPH_SCOPE_ANY := 0
    static PEER_GRAPH_SCOPE_GLOBAL := 1
    static PEER_GRAPH_SCOPE_SITELOCAL := 2
    static PEER_GRAPH_SCOPE_LINKLOCAL := 3
    static PEER_GRAPH_SCOPE_LOOPBACK := 4
}
struct PEER_GRAPH_PROPERTIES {
    dwSize : UInt32
    dwFlags : UInt32
    dwScope : UInt32
    dwMaxRecordSize : UInt32
    pwzGraphId : PWSTR
    pwzCreatorId : PWSTR
    pwzFriendlyName : PWSTR
    pwzComment : PWSTR
    ulPresenceLifetime : UInt32
    cPresenceMax : UInt32
}
struct PEER_NODE_INFO {
    dwSize : UInt32
    ullNodeId : Int64
    pwzPeerId : PWSTR
    cAddresses : UInt32
    pAddresses : PEER_ADDRESS.Ptr
    pwzAttributes : PWSTR
}
struct PEER_EVENT_NODE_CHANGE_DATA {
    dwSize : UInt32
    changeType : PEER_NODE_CHANGE_TYPE
    ullNodeId : Int64
    pwzPeerId : PWSTR
}
struct PEER_GRAPH_EVENT_REGISTRATION {
    eventType : PEER_GRAPH_EVENT_TYPE
    pType : GUID.Ptr
}
struct PEER_GRAPH_EVENT_DATA {
    eventType : PEER_GRAPH_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwStatus : PEER_GRAPH_STATUS_FLAGS
            incomingData : PEER_EVENT_INCOMING_DATA
            recordChangeData : PEER_EVENT_RECORD_CHANGE_DATA
            connectionChangeData : PEER_EVENT_CONNECTION_CHANGE_DATA
            nodeChangeData : PEER_EVENT_NODE_CHANGE_DATA
            synchronizedData : PEER_EVENT_SYNCHRONIZED_DATA
        }
    }
}
struct PFNPEER_VALIDATE_RECORD extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, PEER_RECORD.Ptr, PEER_RECORD_CHANGE_TYPE, HRESULT]
}
struct PFNPEER_SECURE_RECORD extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, PEER_RECORD.Ptr, PEER_RECORD_CHANGE_TYPE, PEER_DATA.Ptr.Ptr, HRESULT]
}
struct PFNPEER_FREE_SECURITY_DATA extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, PEER_DATA.Ptr, HRESULT]
}
struct PFNPEER_ON_PASSWORD_AUTH_FAILED extends FunctionPointer {
    static Types := [Struct.Ptr, Struct.Ptr, HRESULT]
}
struct PEER_SECURITY_INTERFACE {
    dwSize : UInt32
    pwzSspFilename : PWSTR
    pwzPackageName : PWSTR
    cbSecurityInfo : UInt32
    pbSecurityInfo : UInt8.Ptr
    pvContext : Struct.Ptr
    pfnValidateRecord : PFNPEER_VALIDATE_RECORD
    pfnSecureRecord : PFNPEER_SECURE_RECORD
    pfnFreeSecurityData : PFNPEER_FREE_SECURITY_DATA
    pfnAuthFailed : PFNPEER_ON_PASSWORD_AUTH_FAILED
}
struct PEER_GROUP_EVENT_TYPE extends Int32 {
    static PEER_GROUP_EVENT_STATUS_CHANGED := 1
    static PEER_GROUP_EVENT_PROPERTY_CHANGED := 2
    static PEER_GROUP_EVENT_RECORD_CHANGED := 3
    static PEER_GROUP_EVENT_DIRECT_CONNECTION := 4
    static PEER_GROUP_EVENT_NEIGHBOR_CONNECTION := 5
    static PEER_GROUP_EVENT_INCOMING_DATA := 6
    static PEER_GROUP_EVENT_MEMBER_CHANGED := 8
    static PEER_GROUP_EVENT_CONNECTION_FAILED := 10
    static PEER_GROUP_EVENT_AUTHENTICATION_FAILED := 11
}
struct PEER_GROUP_STATUS extends Int32 {
    static PEER_GROUP_STATUS_LISTENING := 1
    static PEER_GROUP_STATUS_HAS_CONNECTIONS := 2
}
struct PEER_GROUP_PROPERTY_FLAGS extends Int32 {
    static PEER_MEMBER_DATA_OPTIONAL := 1
    static PEER_DISABLE_PRESENCE := 2
    static PEER_DEFER_EXPIRATION := 4
}
struct PEER_GROUP_AUTHENTICATION_SCHEME extends Int32 {
    static PEER_GROUP_GMC_AUTHENTICATION := 1
    static PEER_GROUP_PASSWORD_AUTHENTICATION := 2
}
struct PEER_MEMBER_FLAGS extends Int32 {
    static PEER_MEMBER_PRESENT := 1
}
struct PEER_MEMBER_CHANGE_TYPE extends Int32 {
    static PEER_MEMBER_CONNECTED := 1
    static PEER_MEMBER_DISCONNECTED := 2
    static PEER_MEMBER_UPDATED := 3
    static PEER_MEMBER_JOINED := 4
    static PEER_MEMBER_LEFT := 5
}
struct PEER_GROUP_ISSUE_CREDENTIAL_FLAGS extends Int32 {
    static PEER_GROUP_STORE_CREDENTIALS := 1
}
struct PEER_CREDENTIAL_INFO {
    dwSize : UInt32
    dwFlags : UInt32
    pwzFriendlyName : PWSTR
    pPublicKey : CERT_PUBLIC_KEY_INFO.Ptr
    pwzIssuerPeerName : PWSTR
    pwzIssuerFriendlyName : PWSTR
    ftValidityStart : FILETIME
    ftValidityEnd : FILETIME
    cRoles : UInt32
    pRoles : GUID.Ptr
}
struct PEER_MEMBER {
    dwSize : UInt32
    dwFlags : UInt32
    pwzIdentity : PWSTR
    pwzAttributes : PWSTR
    ullNodeId : Int64
    cAddresses : UInt32
    pAddresses : PEER_ADDRESS.Ptr
    pCredentialInfo : PEER_CREDENTIAL_INFO.Ptr
}
struct PEER_INVITATION_INFO {
    dwSize : UInt32
    dwFlags : UInt32
    pwzCloudName : PWSTR
    dwScope : UInt32
    dwCloudFlags : UInt32
    pwzGroupPeerName : PWSTR
    pwzIssuerPeerName : PWSTR
    pwzSubjectPeerName : PWSTR
    pwzGroupFriendlyName : PWSTR
    pwzIssuerFriendlyName : PWSTR
    pwzSubjectFriendlyName : PWSTR
    ftValidityStart : FILETIME
    ftValidityEnd : FILETIME
    cRoles : UInt32
    pRoles : GUID.Ptr
    cClassifiers : UInt32
    ppwzClassifiers : PWSTR.Ptr
    pSubjectPublicKey : CERT_PUBLIC_KEY_INFO.Ptr
    authScheme : PEER_GROUP_AUTHENTICATION_SCHEME
}
struct PEER_GROUP_PROPERTIES {
    dwSize : UInt32
    dwFlags : UInt32
    pwzCloud : PWSTR
    pwzClassifier : PWSTR
    pwzGroupPeerName : PWSTR
    pwzCreatorPeerName : PWSTR
    pwzFriendlyName : PWSTR
    pwzComment : PWSTR
    ulMemberDataLifetime : UInt32
    ulPresenceLifetime : UInt32
    dwAuthenticationSchemes : UInt32
    pwzGroupPassword : PWSTR
    groupPasswordRole : GUID
}
struct PEER_EVENT_MEMBER_CHANGE_DATA {
    dwSize : UInt32
    changeType : PEER_MEMBER_CHANGE_TYPE
    pwzIdentity : PWSTR
}
struct PEER_GROUP_EVENT_REGISTRATION {
    eventType : PEER_GROUP_EVENT_TYPE
    pType : GUID.Ptr
}
struct PEER_GROUP_EVENT_DATA {
    eventType : PEER_GROUP_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            dwStatus : PEER_GROUP_STATUS
            incomingData : PEER_EVENT_INCOMING_DATA
            recordChangeData : PEER_EVENT_RECORD_CHANGE_DATA
            connectionChangeData : PEER_EVENT_CONNECTION_CHANGE_DATA
            memberChangeData : PEER_EVENT_MEMBER_CHANGE_DATA
            hrConnectionFailedReason : HRESULT
        }
    }
}
struct PEER_NAME_PAIR {
    dwSize : UInt32
    pwzPeerName : PWSTR
    pwzFriendlyName : PWSTR
}
struct PEER_SIGNIN_FLAGS extends Int32 {
    static PEER_SIGNIN_NONE := 0
    static PEER_SIGNIN_NEAR_ME := 1
    static PEER_SIGNIN_INTERNET := 2
    static PEER_SIGNIN_ALL := 3
}
struct PEER_WATCH_PERMISSION extends Int32 {
    static PEER_WATCH_BLOCKED := 0
    static PEER_WATCH_ALLOWED := 1
}
struct PEER_PUBLICATION_SCOPE extends Int32 {
    static PEER_PUBLICATION_SCOPE_NONE := 0
    static PEER_PUBLICATION_SCOPE_NEAR_ME := 1
    static PEER_PUBLICATION_SCOPE_INTERNET := 2
    static PEER_PUBLICATION_SCOPE_ALL := 3
}
struct PEER_APPLICATION {
    id : GUID
    data : PEER_DATA
    pwzDescription : PWSTR
}
struct PEER_OBJECT {
    id : GUID
    data : PEER_DATA
    dwPublicationScope : UInt32
}
struct PEER_CONTACT {
    pwzPeerName : PWSTR
    pwzNickName : PWSTR
    pwzDisplayName : PWSTR
    pwzEmailAddress : PWSTR
    fWatch : BOOL
    WatcherPermissions : PEER_WATCH_PERMISSION
    credentials : PEER_DATA
}
struct PEER_ENDPOINT {
    address : PEER_ADDRESS
    pwzEndpointName : PWSTR
}
struct PEER_PEOPLE_NEAR_ME {
    pwzNickName : PWSTR
    endpoint : PEER_ENDPOINT
    id : GUID
}
struct PEER_INVITATION_RESPONSE_TYPE extends Int32 {
    static PEER_INVITATION_RESPONSE_DECLINED := 0
    static PEER_INVITATION_RESPONSE_ACCEPTED := 1
    static PEER_INVITATION_RESPONSE_EXPIRED := 2
    static PEER_INVITATION_RESPONSE_ERROR := 3
}
struct PEER_APPLICATION_REGISTRATION_TYPE extends Int32 {
    static PEER_APPLICATION_CURRENT_USER := 0
    static PEER_APPLICATION_ALL_USERS := 1
}
struct PEER_INVITATION {
    applicationId : GUID
    applicationData : PEER_DATA
    pwzMessage : PWSTR
}
struct PEER_INVITATION_RESPONSE {
    action : PEER_INVITATION_RESPONSE_TYPE
    pwzMessage : PWSTR
    hrExtendedInfo : HRESULT
}
struct PEER_APP_LAUNCH_INFO {
    pContact : PEER_CONTACT.Ptr
    pEndpoint : PEER_ENDPOINT.Ptr
    pInvitation : PEER_INVITATION.Ptr
}
struct PEER_APPLICATION_REGISTRATION_INFO {
    application : PEER_APPLICATION
    pwzApplicationToLaunch : PWSTR
    pwzApplicationArguments : PWSTR
    dwPublicationScope : UInt32
}
struct PEER_PRESENCE_STATUS extends Int32 {
    static PEER_PRESENCE_OFFLINE := 0
    static PEER_PRESENCE_OUT_TO_LUNCH := 1
    static PEER_PRESENCE_AWAY := 2
    static PEER_PRESENCE_BE_RIGHT_BACK := 3
    static PEER_PRESENCE_IDLE := 4
    static PEER_PRESENCE_BUSY := 5
    static PEER_PRESENCE_ON_THE_PHONE := 6
    static PEER_PRESENCE_ONLINE := 7
}
struct PEER_PRESENCE_INFO {
    status : PEER_PRESENCE_STATUS
    pwzDescriptiveText : PWSTR
}
struct PEER_CHANGE_TYPE extends Int32 {
    static PEER_CHANGE_ADDED := 0
    static PEER_CHANGE_DELETED := 1
    static PEER_CHANGE_UPDATED := 2
}
struct PEER_COLLAB_EVENT_TYPE extends Int32 {
    static PEER_EVENT_WATCHLIST_CHANGED := 1
    static PEER_EVENT_ENDPOINT_CHANGED := 2
    static PEER_EVENT_ENDPOINT_PRESENCE_CHANGED := 3
    static PEER_EVENT_ENDPOINT_APPLICATION_CHANGED := 4
    static PEER_EVENT_ENDPOINT_OBJECT_CHANGED := 5
    static PEER_EVENT_MY_ENDPOINT_CHANGED := 6
    static PEER_EVENT_MY_PRESENCE_CHANGED := 7
    static PEER_EVENT_MY_APPLICATION_CHANGED := 8
    static PEER_EVENT_MY_OBJECT_CHANGED := 9
    static PEER_EVENT_PEOPLE_NEAR_ME_CHANGED := 10
    static PEER_EVENT_REQUEST_STATUS_CHANGED := 11
}
struct PEER_COLLAB_EVENT_REGISTRATION {
    eventType : PEER_COLLAB_EVENT_TYPE
    pInstance : GUID.Ptr
}
struct PEER_EVENT_WATCHLIST_CHANGED_DATA {
    pContact : PEER_CONTACT.Ptr
    changeType : PEER_CHANGE_TYPE
}
struct PEER_EVENT_PRESENCE_CHANGED_DATA {
    pContact : PEER_CONTACT.Ptr
    pEndpoint : PEER_ENDPOINT.Ptr
    changeType : PEER_CHANGE_TYPE
    pPresenceInfo : PEER_PRESENCE_INFO.Ptr
}
struct PEER_EVENT_APPLICATION_CHANGED_DATA {
    pContact : PEER_CONTACT.Ptr
    pEndpoint : PEER_ENDPOINT.Ptr
    changeType : PEER_CHANGE_TYPE
    pApplication : PEER_APPLICATION.Ptr
}
struct PEER_EVENT_OBJECT_CHANGED_DATA {
    pContact : PEER_CONTACT.Ptr
    pEndpoint : PEER_ENDPOINT.Ptr
    changeType : PEER_CHANGE_TYPE
    pObject : PEER_OBJECT.Ptr
}
struct PEER_EVENT_ENDPOINT_CHANGED_DATA {
    pContact : PEER_CONTACT.Ptr
    pEndpoint : PEER_ENDPOINT.Ptr
}
struct PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA {
    changeType : PEER_CHANGE_TYPE
    pPeopleNearMe : PEER_PEOPLE_NEAR_ME.Ptr
}
struct PEER_EVENT_REQUEST_STATUS_CHANGED_DATA {
    pEndpoint : PEER_ENDPOINT.Ptr
    hrChange : HRESULT
}
struct PEER_COLLAB_EVENT_DATA {
    eventType : PEER_COLLAB_EVENT_TYPE
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            watchListChangedData : PEER_EVENT_WATCHLIST_CHANGED_DATA
            presenceChangedData : PEER_EVENT_PRESENCE_CHANGED_DATA
            applicationChangedData : PEER_EVENT_APPLICATION_CHANGED_DATA
            objectChangedData : PEER_EVENT_OBJECT_CHANGED_DATA
            endpointChangedData : PEER_EVENT_ENDPOINT_CHANGED_DATA
            peopleNearMeChangedData : PEER_EVENT_PEOPLE_NEAR_ME_CHANGED_DATA
            requestStatusChangedData : PEER_EVENT_REQUEST_STATUS_CHANGED_DATA
        }
    }
}
struct PEER_PNRP_ENDPOINT_INFO {
    pwzPeerName : PWSTR
    cAddresses : UInt32
    ppAddresses : SOCKADDR.Ptr.Ptr
    pwzComment : PWSTR
    payload : PEER_DATA
}
struct PEER_PNRP_CLOUD_INFO {
    pwzCloudName : PWSTR
    dwScope : PNRP_SCOPE
    dwScopeId : UInt32
}
struct PEER_PNRP_REGISTRATION_INFO {
    pwzCloudName : PWSTR
    pwzPublishingIdentity : PWSTR
    cAddresses : UInt32
    ppAddresses : SOCKADDR.Ptr.Ptr
    wPort : UInt16
    pwzComment : PWSTR
    payload : PEER_DATA
}
struct DRT_SCOPE extends Int32 {
    static DRT_GLOBAL_SCOPE := 1
    static DRT_SITE_LOCAL_SCOPE := 2
    static DRT_LINK_LOCAL_SCOPE := 3
}
struct DRT_STATUS extends Int32 {
    static DRT_ACTIVE := 0
    static DRT_ALONE := 1
    static DRT_NO_NETWORK := 10
    static DRT_FAULTED := 20
}
struct DRT_MATCH_TYPE extends Int32 {
    static DRT_MATCH_EXACT := 0
    static DRT_MATCH_NEAR := 1
    static DRT_MATCH_INTERMEDIATE := 2
}
struct DRT_LEAFSET_KEY_CHANGE_TYPE extends Int32 {
    static DRT_LEAFSET_KEY_ADDED := 0
    static DRT_LEAFSET_KEY_DELETED := 1
}
struct DRT_EVENT_TYPE extends Int32 {
    static DRT_EVENT_STATUS_CHANGED := 0
    static DRT_EVENT_LEAFSET_KEY_CHANGED := 1
    static DRT_EVENT_REGISTRATION_STATE_CHANGED := 2
}
struct DRT_SECURITY_MODE extends Int32 {
    static DRT_SECURE_RESOLVE := 0
    static DRT_SECURE_MEMBERSHIP := 1
    static DRT_SECURE_CONFIDENTIALPAYLOAD := 2
}
struct DRT_REGISTRATION_STATE extends Int32 {
    static DRT_REGISTRATION_STATE_UNRESOLVEABLE := 1
}
struct DRT_ADDRESS_FLAGS extends Int32 {
    static DRT_ADDRESS_FLAG_ACCEPTED := 1
    static DRT_ADDRESS_FLAG_REJECTED := 2
    static DRT_ADDRESS_FLAG_UNREACHABLE := 4
    static DRT_ADDRESS_FLAG_LOOP := 8
    static DRT_ADDRESS_FLAG_TOO_BUSY := 16
    static DRT_ADDRESS_FLAG_BAD_VALIDATE_ID := 32
    static DRT_ADDRESS_FLAG_SUSPECT_UNREGISTERED_ID := 64
    static DRT_ADDRESS_FLAG_INQUIRE := 128
}
struct DRT_DATA {
    cb : UInt32
    pb : UInt8.Ptr
}
struct DRT_REGISTRATION {
    key : DRT_DATA
    appData : DRT_DATA
}
struct DRT_SECURITY_PROVIDER {
    pvContext : Struct.Ptr
    Attach : IntPtr
    Detach : IntPtr
    RegisterKey : IntPtr
    UnregisterKey : IntPtr
    ValidateAndUnpackPayload : IntPtr
    SecureAndPackPayload : IntPtr
    FreeData : IntPtr
    EncryptData : IntPtr
    DecryptData : IntPtr
    GetSerializedCredential : IntPtr
    ValidateRemoteCredential : IntPtr
    SignData : IntPtr
    VerifyData : IntPtr
}
struct DRT_BOOTSTRAP_RESOLVE_CALLBACK extends FunctionPointer {
    static Types := [HRESULT, Struct.Ptr, SOCKET_ADDRESS_LIST.Ptr, BOOL, "Void"]
}
struct DRT_BOOTSTRAP_PROVIDER {
    pvContext : Struct.Ptr
    Attach : IntPtr
    Detach : IntPtr
    InitResolve : IntPtr
    IssueResolve : IntPtr
    EndResolve : IntPtr
    Register : IntPtr
    Unregister : IntPtr
}
struct DRT_SETTINGS {
    dwSize : UInt32
    cbKey : UInt32
    bProtocolMajorVersion : UInt8
    bProtocolMinorVersion : UInt8
    ulMaxRoutingAddresses : UInt32
    pwzDrtInstancePrefix : PWSTR
    hTransport : Struct.Ptr
    pSecurityProvider : DRT_SECURITY_PROVIDER.Ptr
    pBootstrapProvider : DRT_BOOTSTRAP_PROVIDER.Ptr
    eSecurityMode : DRT_SECURITY_MODE
}
struct DRT_SEARCH_INFO {
    dwSize : UInt32
    fIterative : BOOL
    fAllowCurrentInstanceMatch : BOOL
    fAnyMatchInRange : BOOL
    cMaxEndpoints : UInt32
    pMaximumKey : DRT_DATA.Ptr
    pMinimumKey : DRT_DATA.Ptr
}
struct DRT_ADDRESS {
    socketAddress : SOCKADDR_STORAGE
    flags : UInt32
    nearness : Int32
    latency : UInt32
}
struct DRT_ADDRESS_LIST {
    AddressCount : UInt32
    AddressList : DRT_ADDRESS[1]
}
struct DRT_SEARCH_RESULT {
    dwSize : UInt32
    type : DRT_MATCH_TYPE
    pvContext : Struct.Ptr
    registration : DRT_REGISTRATION
}
struct DRT_EVENT_DATA {
    type : DRT_EVENT_TYPE
    hr : HRESULT
    pvContext : Struct.Ptr
    Anonymous : this._Anonymous_e__Union
    struct _Anonymous_e__Union {
        union {
            leafsetKeyChange : this._leafsetKeyChange_e__Struct
            registrationStateChange : this._registrationStateChange_e__Struct
            statusChange : this._statusChange_e__Struct
        }
        struct _leafsetKeyChange_e__Struct {
            change : DRT_LEAFSET_KEY_CHANGE_TYPE
            localKey : DRT_DATA
            remoteKey : DRT_DATA
        }
        struct _registrationStateChange_e__Struct {
            state : DRT_REGISTRATION_STATE
            localKey : DRT_DATA
        }
        struct _statusChange_e__Struct {
            status : DRT_STATUS
            bootstrapAddresses : this._bootstrapAddresses_e__Struct
            struct _bootstrapAddresses_e__Struct {
                cntAddress : UInt32
                pAddresses : SOCKADDR_STORAGE.Ptr
            }
        }
    }
}
struct PEERDIST_STATUS extends Int32 {
    static PEERDIST_STATUS_DISABLED := 0
    static PEERDIST_STATUS_UNAVAILABLE := 1
    static PEERDIST_STATUS_AVAILABLE := 2
}
struct PEERDIST_PUBLICATION_OPTIONS {
    dwVersion : UInt32
    dwFlags : UInt32
}
struct PEERDIST_CONTENT_TAG {
    Data : UInt8[16]
}
struct PEERDIST_RETRIEVAL_OPTIONS {
    cbSize : UInt32 := this.Size
    dwContentInfoMinVersion : UInt32
    dwContentInfoMaxVersion : UInt32
    dwReserved : UInt32
}
struct PEERDIST_STATUS_INFO {
    cbSize : UInt32 := this.Size
    status : PEERDIST_STATUS
    dwMinVer : PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_VALUE
    dwMaxVer : PEERDIST_RETRIEVAL_OPTIONS_CONTENTINFO_VERSION_VALUE
}
struct PEERDIST_CLIENT_INFO_BY_HANDLE_CLASS extends Int32 {
    static PeerDistClientBasicInfo := 0
    static MaximumPeerDistClientInfoByHandlesClass := 1
}
struct PEERDIST_CLIENT_BASIC_INFO {
    fFlashCrowd : BOOL
}
