-- Script Date: 03/12/2014 09:23  - ErikEJ.SqlCeScripting version 3.5.2.43
-- Database information:
-- Locale Identifier: 2057
-- Encryption Mode: 
-- Case Sensitive: False
-- Database: C:\Projects\Umbraco.DeployHelper\Test.Web\App_Data\Umbraco.sdf
-- ServerVersion: 4.0.8876.1
-- DatabaseSize: 832 KB
-- Created: 28/11/2014 22:58

-- User Table information:
-- Number of tables: 42
-- cmsContent: 4 row(s)
-- cmsContentType: 5 row(s)
-- cmsContentTypeAllowedContentType: 5 row(s)
-- cmsContentVersion: 10 row(s)
-- cmsContentXml: 4 row(s)
-- cmsDataType: 32 row(s)
-- cmsDataTypePreValues: 2 row(s)
-- cmsDictionary: 0 row(s)
-- cmsDocument: 10 row(s)
-- cmsDocumentType: 2 row(s)
-- cmsLanguageText: 0 row(s)
-- cmsMacro: 2 row(s)
-- cmsMacroProperty: 0 row(s)
-- cmsMacroPropertyType: 16 row(s)
-- cmsMember: -1 row(s)
-- cmsMember2MemberGroup: 0 row(s)
-- cmsMemberType: 0 row(s)
-- cmsPreviewXml: -1 row(s)
-- cmsPropertyData: 24 row(s)
-- cmsPropertyType: 14 row(s)
-- cmsStylesheet: -1 row(s)
-- cmsStylesheetProperty: -1 row(s)
-- cmsTab: 6 row(s)
-- cmsTagRelationship: -1 row(s)
-- cmsTags: -1 row(s)
-- cmsTask: 0 row(s)
-- cmsTaskType: 1 row(s)
-- cmsTemplate: 3 row(s)
-- umbracoApp: 0 row(s)
-- umbracoAppTree: 0 row(s)
-- umbracoDomains: 0 row(s)
-- umbracoLanguage: 1 row(s)
-- umbracoLog: 56 row(s)
-- umbracoNode: 38 row(s)
-- umbracoRelation: 0 row(s)
-- umbracoRelationType: 1 row(s)
-- umbracoUser: 1 row(s)
-- umbracoUser2app: 6 row(s)
-- umbracoUser2NodeNotify: 0 row(s)
-- umbracoUser2NodePermission: 0 row(s)
-- umbracoUserLogins: -1 row(s)
-- umbracoUserType: 4 row(s)

CREATE TABLE [umbracoUserType] (
  [id] INTEGER NOT NULL
, [userTypeAlias] nvarchar(50) NULL
, [userTypeName] nvarchar(255) NOT NULL
, [userTypeDefaultPermissions] nvarchar(50) NULL
, CONSTRAINT [PK_userType] PRIMARY KEY ([id])
);
CREATE TABLE [umbracoUserLogins] (
  [contextID] uniqueidentifier NOT NULL
, [userID] int NOT NULL
, [timeout] bigint NOT NULL
);
CREATE TABLE [umbracoUser2NodePermission] (
  [userId] int NOT NULL
, [nodeId] int NOT NULL
, [permission] nchar(1) NOT NULL
, CONSTRAINT [PK_umbracoUser2NodePermission] PRIMARY KEY ([userId],[nodeId],[permission])
);
CREATE TABLE [umbracoUser2NodeNotify] (
  [userId] int NOT NULL
, [nodeId] int NOT NULL
, [action] nchar(1) NOT NULL
, CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY ([userId],[nodeId],[action])
);
CREATE TABLE [umbracoUser] (
  [id] INTEGER NOT NULL
, [userDisabled] bit DEFAULT (0) NOT NULL
, [userNoConsole] bit DEFAULT (0) NOT NULL
, [userType] int NOT NULL
, [startStructureID] int NOT NULL
, [startMediaID] int NULL
, [userName] nvarchar(255) NOT NULL
, [userLogin] nvarchar(125) NOT NULL
, [userPassword] nvarchar(125) NOT NULL
, [userEmail] nvarchar(255) NOT NULL
, [userDefaultPermissions] nvarchar(50) NULL
, [userLanguage] nvarchar(10) NULL
, [defaultToLiveEditing] bit DEFAULT (0) NOT NULL
, CONSTRAINT [PK_user] PRIMARY KEY ([id])
, FOREIGN KEY ([userType]) REFERENCES [umbracoUserType] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [umbracoUser2app] (
  [user] int NOT NULL
, [app] nvarchar(50) NOT NULL
, CONSTRAINT [PK_user2app] PRIMARY KEY ([user],[app])
, FOREIGN KEY ([user]) REFERENCES [umbracoUser] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [umbracoRelationType] (
  [id] INTEGER NOT NULL
, [dual] bit NOT NULL
, [parentObjectType] uniqueidentifier NOT NULL
, [childObjectType] uniqueidentifier NOT NULL
, [name] nvarchar(255) NOT NULL
, [alias] nvarchar(100) NULL
, CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY ([id])
);
CREATE TABLE [umbracoRelation] (
  [id] INTEGER NOT NULL
, [parentId] int NOT NULL
, [childId] int NOT NULL
, [relType] int NOT NULL
, [datetime] datetime DEFAULT (getdate()) NOT NULL
, [comment] nvarchar(1000) NOT NULL
, CONSTRAINT [PK_umbracoRelation] PRIMARY KEY ([id])
);
CREATE TABLE [umbracoNode] (
  [id] INTEGER NOT NULL
, [trashed] bit DEFAULT (0) NOT NULL
, [parentID] int NOT NULL
, [nodeUser] int NULL
, [level] int NOT NULL
, [path] nvarchar(150) NOT NULL
, [sortOrder] int NOT NULL
, [uniqueID] uniqueidentifier NULL
, [text] nvarchar(255) NULL
, [nodeObjectType] uniqueidentifier NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, CONSTRAINT [PK_structure] PRIMARY KEY ([id])
, FOREIGN KEY ([parentID]) REFERENCES [umbracoNode] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [umbracoLog] (
  [id] INTEGER NOT NULL
, [userId] int NOT NULL
, [NodeId] int NOT NULL
, [Datestamp] datetime DEFAULT (getdate()) NOT NULL
, [logHeader] nvarchar(50) NOT NULL
, [logComment] nvarchar(4000) NULL
, CONSTRAINT [PK_umbracoLog] PRIMARY KEY ([id])
);
CREATE TABLE [umbracoLanguage] (
  [id] INTEGER NOT NULL
, [languageISOCode] nvarchar(10) NULL
, [languageCultureName] nvarchar(100) NULL
, CONSTRAINT [PK_language] PRIMARY KEY ([id])
);
CREATE TABLE [umbracoDomains] (
  [id] INTEGER NOT NULL
, [domainDefaultLanguage] int NULL
, [domainRootStructureID] int NULL
, [domainName] nvarchar(255) NOT NULL
, CONSTRAINT [PK_domains] PRIMARY KEY ([id])
);
CREATE TABLE [umbracoAppTree] (
  [treeSilent] bit DEFAULT (0) NOT NULL
, [treeInitialize] bit DEFAULT (1) NOT NULL
, [treeSortOrder] tinyint NOT NULL
, [appAlias] nvarchar(50) NOT NULL
, [treeAlias] nvarchar(150) NOT NULL
, [treeTitle] nvarchar(255) NOT NULL
, [treeIconClosed] nvarchar(255) NOT NULL
, [treeIconOpen] nvarchar(255) NOT NULL
, [treeHandlerAssembly] nvarchar(255) NOT NULL
, [treeHandlerType] nvarchar(255) NOT NULL
, [action] nvarchar(255) NULL
, CONSTRAINT [PK_umbracoAppTree] PRIMARY KEY ([appAlias],[treeAlias])
);
CREATE TABLE [umbracoApp] (
  [sortOrder] tinyint DEFAULT (0) NOT NULL
, [appAlias] nvarchar(50) NOT NULL
, [appIcon] nvarchar(255) NOT NULL
, [appName] nvarchar(255) NOT NULL
, [appInitWithTreeAlias] nvarchar(255) NULL
, CONSTRAINT [PK_umbracoApp] PRIMARY KEY ([appAlias])
);
CREATE TABLE [cmsTemplate] (
  [pk] INTEGER NOT NULL
, [nodeId] int NOT NULL
, [master] int NULL
, [alias] nvarchar(100) NULL
, [design] ntext NOT NULL
, CONSTRAINT [PK_templates] PRIMARY KEY ([pk])
, FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsTaskType] (
  [id] INTEGER NOT NULL
, [alias] nvarchar(255) NOT NULL
, CONSTRAINT [PK_cmsTaskType] PRIMARY KEY ([id])
);
CREATE TABLE [cmsTask] (
  [closed] bit DEFAULT ((0)) NOT NULL
, [id] INTEGER NOT NULL
, [taskTypeId] int NOT NULL
, [nodeId] int NOT NULL
, [parentUserId] int NOT NULL
, [userId] int NOT NULL
, [DateTime] datetime DEFAULT (getdate()) NOT NULL
, [Comment] nvarchar(500) NULL
, CONSTRAINT [PK_cmsTask] PRIMARY KEY ([id])
, FOREIGN KEY ([taskTypeId]) REFERENCES [cmsTaskType] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsTags] (
  [id] INTEGER NOT NULL
, [tag] nvarchar(200) NULL
, [parentId] int NULL
, [group] nvarchar(100) NULL
);
CREATE TABLE [cmsTagRelationship] (
  [nodeId] int NOT NULL
, [tagId] int NOT NULL
);
CREATE TABLE [cmsTab] (
  [id] INTEGER NOT NULL
, [contenttypeNodeId] int NOT NULL
, [text] nvarchar(255) NOT NULL
, [sortorder] int NOT NULL
, CONSTRAINT [PK_cmsTab] PRIMARY KEY ([id])
);
CREATE TABLE [cmsStylesheetProperty] (
  [nodeId] int NOT NULL
, [stylesheetPropertyEditor] bit NULL
, [stylesheetPropertyAlias] nvarchar(50) NULL
, [stylesheetPropertyValue] nvarchar(400) NULL
);
CREATE TABLE [cmsStylesheet] (
  [nodeId] int NOT NULL
, [filename] nvarchar(100) NOT NULL
, [content] ntext NULL
);
CREATE TABLE [cmsPropertyType] (
  [id] INTEGER NOT NULL
, [dataTypeId] int NOT NULL
, [contentTypeId] int NOT NULL
, [tabId] int NULL
, [Alias] nvarchar(255) NOT NULL
, [Name] nvarchar(255) NULL
, [helpText] nvarchar(1000) NULL
, [sortOrder] int DEFAULT (0) NOT NULL
, [mandatory] bit DEFAULT (0) NOT NULL
, [validationRegExp] nvarchar(255) NULL
, [Description] nvarchar(2000) NULL
, CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY ([id])
, FOREIGN KEY ([tabId]) REFERENCES [cmsTab] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsPropertyData] (
  [id] INTEGER NOT NULL
, [contentNodeId] int NOT NULL
, [versionId] uniqueidentifier NULL
, [propertytypeid] int NOT NULL
, [dataInt] int NULL
, [dataDate] datetime NULL
, [dataNvarchar] nvarchar(500) NULL
, [dataNtext] ntext NULL
, CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY ([id])
, FOREIGN KEY ([contentNodeId]) REFERENCES [umbracoNode] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsPreviewXml] (
  [nodeId] int NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [timestamp] datetime NOT NULL
, [xml] ntext NOT NULL
);
CREATE TABLE [cmsMemberType] (
  [pk] INTEGER NOT NULL
, [NodeId] int NOT NULL
, [propertytypeId] int NOT NULL
, [memberCanEdit] bit DEFAULT (0) NOT NULL
, [viewOnProfile] bit DEFAULT (0) NOT NULL
, CONSTRAINT [PK_cmsMemberType] PRIMARY KEY ([pk])
);
CREATE TABLE [cmsMember2MemberGroup] (
  [Member] int NOT NULL
, [MemberGroup] int NOT NULL
, CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY ([Member],[MemberGroup])
);
CREATE TABLE [cmsMember] (
  [nodeId] int NOT NULL
, [Email] nvarchar(1000) DEFAULT ('') NOT NULL
, [LoginName] nvarchar(1000) DEFAULT ('') NOT NULL
, [Password] nvarchar(1000) DEFAULT ('') NOT NULL
);
CREATE TABLE [cmsMacroPropertyType] (
  [id] INTEGER NOT NULL
, [macroPropertyTypeAlias] nvarchar(50) NULL
, [macroPropertyTypeRenderAssembly] nvarchar(255) NULL
, [macroPropertyTypeRenderType] nvarchar(255) NULL
, [macroPropertyTypeBaseType] nvarchar(255) NULL
, CONSTRAINT [PK_macroPropertyType] PRIMARY KEY ([id])
);
CREATE TABLE [cmsMacroProperty] (
  [id] INTEGER NOT NULL
, [macroPropertyHidden] bit DEFAULT (0) NOT NULL
, [macroPropertyType] int NOT NULL
, [macro] int NOT NULL
, [macroPropertySortOrder] tinyint DEFAULT (0) NOT NULL
, [macroPropertyAlias] nvarchar(50) NOT NULL
, [macroPropertyName] nvarchar(255) NOT NULL
, CONSTRAINT [PK_macroProperty] PRIMARY KEY ([id])
, FOREIGN KEY ([macroPropertyType]) REFERENCES [cmsMacroPropertyType] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsMacro] (
  [id] INTEGER NOT NULL
, [macroUseInEditor] bit DEFAULT (0) NOT NULL
, [macroRefreshRate] int DEFAULT (0) NOT NULL
, [macroAlias] nvarchar(255) NOT NULL
, [macroName] nvarchar(255) NULL
, [macroScriptType] nvarchar(255) NULL
, [macroScriptAssembly] nvarchar(255) NULL
, [macroXSLT] nvarchar(255) NULL
, [macroCacheByPage] bit DEFAULT (1) NOT NULL
, [macroCachePersonalized] bit DEFAULT (0) NOT NULL
, [macroDontRender] bit DEFAULT (0) NOT NULL
, [macroPython] nvarchar(255) NULL
, CONSTRAINT [PK_macro] PRIMARY KEY ([id])
);
CREATE TABLE [cmsLanguageText] (
  [pk] INTEGER NOT NULL
, [languageId] int NOT NULL
, [UniqueId] uniqueidentifier NOT NULL
, [value] nvarchar(1000) NOT NULL
, CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY ([pk])
);
CREATE TABLE [cmsDocumentType] (
  [contentTypeNodeId] int NOT NULL
, [templateNodeId] int NOT NULL
, [IsDefault] bit DEFAULT (0) NOT NULL
, CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY ([contentTypeNodeId],[templateNodeId])
);
CREATE TABLE [cmsDocument] (
  [nodeId] int NOT NULL
, [published] bit NOT NULL
, [documentUser] int NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [text] nvarchar(255) NOT NULL
, [releaseDate] datetime NULL
, [expireDate] datetime NULL
, [updateDate] datetime DEFAULT (getdate()) NOT NULL
, [templateId] int NULL
, [alias] nvarchar(255) NULL
, [newest] bit DEFAULT (0) NOT NULL
, CONSTRAINT [PK_cmsDocument] PRIMARY KEY ([versionId])
, FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsDictionary] (
  [pk] INTEGER NOT NULL
, [id] uniqueidentifier NOT NULL
, [parent] uniqueidentifier NOT NULL
, [key] nvarchar(1000) NOT NULL
, CONSTRAINT [PK_cmsDictionary] PRIMARY KEY ([pk])
);
CREATE TABLE [cmsDataTypePreValues] (
  [id] INTEGER NOT NULL
, [datatypeNodeId] int NOT NULL
, [value] nvarchar(2500) NULL
, [sortorder] int NOT NULL
, [alias] nvarchar(50) NULL
, CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY ([id])
);
CREATE TABLE [cmsDataType] (
  [pk] INTEGER NOT NULL
, [nodeId] int NOT NULL
, [controlId] uniqueidentifier NOT NULL
, [dbType] nvarchar(50) NOT NULL
, CONSTRAINT [PK_cmsDataType] PRIMARY KEY ([pk])
);
CREATE TABLE [cmsContentXml] (
  [nodeId] int NOT NULL
, [xml] ntext NOT NULL
, CONSTRAINT [PK_cmsContentXml] PRIMARY KEY ([nodeId])
);
CREATE TABLE [cmsContentVersion] (
  [id] INTEGER NOT NULL
, [ContentId] int NOT NULL
, [VersionId] uniqueidentifier NOT NULL
, [VersionDate] datetime DEFAULT (getdate()) NOT NULL
, CONSTRAINT [PK__cmsContentVersion__00000000000001BB] PRIMARY KEY ([id])
);
CREATE TABLE [cmsContentTypeAllowedContentType] (
  [Id] int NOT NULL
, [AllowedId] int NOT NULL
, CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY ([Id],[AllowedId])
);
CREATE TABLE [cmsContentType] (
  [pk] INTEGER NOT NULL
, [nodeId] int NOT NULL
, [alias] nvarchar(255) NULL
, [icon] nvarchar(255) NULL
, [thumbnail] nvarchar(255) DEFAULT ('folder.png') NOT NULL
, [description] nvarchar(1500) NULL
, [masterContentType] int DEFAULT (0) NULL
, CONSTRAINT [PK_cmsContentType] PRIMARY KEY ([pk])
, FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [cmsContent] (
  [pk] INTEGER NOT NULL
, [nodeId] int NOT NULL
, [contentType] int NOT NULL
, CONSTRAINT [PK_cmsContent] PRIMARY KEY ([pk])
, FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
INSERT INTO [umbracoUserType] ([id],[userTypeAlias],[userTypeName],[userTypeDefaultPermissions]) VALUES (1,'admin','Administrators','CADMOSKTPIURZ:5F');
INSERT INTO [umbracoUserType] ([id],[userTypeAlias],[userTypeName],[userTypeDefaultPermissions]) VALUES (2,'writer','Writer','CAH:F');
INSERT INTO [umbracoUserType] ([id],[userTypeAlias],[userTypeName],[userTypeDefaultPermissions]) VALUES (3,'editor','Editors','CADMOSKTPUZ:5F');
INSERT INTO [umbracoUserType] ([id],[userTypeAlias],[userTypeName],[userTypeDefaultPermissions]) VALUES (4,'translator','Translator','AF');
INSERT INTO [umbracoUserLogins] ([contextID],[userID],[timeout]) VALUES ('96d23d86-3990-4dc0-ad67-8e3c99f3293d',0,635528183504647167);
INSERT INTO [umbracoUser] ([id],[userDisabled],[userNoConsole],[userType],[startStructureID],[startMediaID],[userName],[userLogin],[userPassword],[userEmail],[userDefaultPermissions],[userLanguage],[defaultToLiveEditing]) VALUES (0,0,0,1,-1,-1,'umbraco.4.11.9','umbraco','/7IIcyNxAts3fvQYe2PI3d19cDU=','admin@domain.com',NULL,'en',0);
INSERT INTO [umbracoUser2app] ([user],[app]) VALUES (0,'content');
INSERT INTO [umbracoUser2app] ([user],[app]) VALUES (0,'developer');
INSERT INTO [umbracoUser2app] ([user],[app]) VALUES (0,'media');
INSERT INTO [umbracoUser2app] ([user],[app]) VALUES (0,'member');
INSERT INTO [umbracoUser2app] ([user],[app]) VALUES (0,'settings');
INSERT INTO [umbracoUser2app] ([user],[app]) VALUES (0,'users');
INSERT INTO [umbracoRelationType] ([id],[dual],[parentObjectType],[childObjectType],[name],[alias]) VALUES (1,1,'c66ba18e-eaf3-4cff-8a22-41b16d66a972','c66ba18e-eaf3-4cff-8a22-41b16d66a972','Relate Document On Copy','relateDocumentOnCopy');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-1,0,-1,0,0,'-1',0,'916724a5-173d-4619-b97e-b9de133dd6f5','SYSTEM DATA: umbraco master root','ea7d8624-4cfe-4578-a871-24aa946bf34d','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-92,0,-1,0,11,'-1,-92',37,'f0bc4bfb-b499-40d6-ba86-058885a5178c','Label','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-90,0,-1,0,11,'-1,-90',35,'84c6b441-31df-4ffe-b67e-67d5bc3ae65a','Upload','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-89,0,-1,0,11,'-1,-89',34,'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3','Textbox multiple','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-88,0,-1,0,11,'-1,-88',33,'0cc0eba1-9960-42c9-bf9b-60e150b429ae','Textstring','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-87,0,-1,0,11,'-1,-87',32,'ca90c950-0aff-4e72-b976-a30b1ac57dad','Richtext editor','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-51,0,-1,0,11,'-1,-51',4,'2e6d3631-066e-44b8-aec4-96f09099b2b5','Numeric','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-49,0,-1,0,11,'-1,-49',2,'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49','True/false','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-09-30 14:01:49.920');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-43,0,-1,0,1,'-1,-43',2,'fbaf13a8-4036-41f2-93a3-974f678c312a','Checkbox list','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:11:04.367');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-42,0,-1,0,1,'-1,-42',2,'0b6a45e7-44ba-430d-9da5-4e46060b9e03','Dropdown','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:59.000');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-41,0,-1,0,1,'-1,-41',2,'5046194e-4237-453c-a547-15db3a07c4e1','Date Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:54.303');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-40,0,-1,0,1,'-1,-40',2,'bb5f57c9-ce2b-4bb9-b697-4caca783a805','Radiobox','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:49.253');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-39,0,-1,0,1,'-1,-39',2,'f38f0ac7-1d27-439c-9f3f-089cd8825a53','Dropdown multiple','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:44.480');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-38,0,-1,0,1,'-1,-38',2,'fd9f1447-6c61-4a7c-9595-5aa39147d318','Folder Browser','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:37.020');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-37,0,-1,0,1,'-1,-37',2,'0225af17-b302-49cb-9176-b9f35cab9c17','Approved Color','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:30.580');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-36,0,-1,0,1,'-1,-36',2,'e4d66c0f-b935-4200-81f0-025f7256b89a','Date Picker with time','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2004-10-15 14:10:23.007');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-21,0,-1,0,0,'-1,-21',0,'bf7c7cbc-952f-4518-97a2-69e9c7b33842','Recycle Bin','cf3d8e34-1c1c-41e9-ae56-878b57b32113','2014-11-28 22:58:54.950');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (-20,0,-1,0,0,'-1,-20',0,'0f582a79-1e41-4cf0-bfa0-76340651891a','Recycle Bin','01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8','2014-11-28 22:58:54.937');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1031,0,-1,1,1,'-1,1031',2,'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d','Folder','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e','2004-12-01 00:13:40.743');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1032,0,-1,1,1,'-1,1032',2,'cc07b313-0843-4aa8-bbda-871c8da728c8','Image','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e','2004-12-01 00:13:43.737');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1033,0,-1,1,1,'-1,1033',2,'4c52d8ab-54e6-40cd-999c-7a5f24903e4d','File','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e','2004-12-01 00:13:46.210');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1034,0,-1,0,1,'-1,1034',2,'a6857c73-d6e9-480c-b6e6-f15f6ad11125','Content Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:29.203');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1035,0,-1,0,1,'-1,1035',2,'93929b9a-93a2-4e2a-b239-d99334440a59','Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:36.143');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1036,0,-1,0,1,'-1,1036',2,'2b24165f-9782-4aa3-b459-1de4a4d21f60','Member Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:40.260');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1038,0,-1,0,1,'-1,1038',2,'1251c96c-185c-4e9b-93f4-b48205573cbd','Simple Editor','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:55.250');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1039,0,-1,0,1,'-1,1039',2,'06f349a9-c949-4b6a-8660-59c10451af42','Ultimate Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:55.250');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1040,0,-1,0,1,'-1,1040',2,'21e798da-e06e-4eda-a511-ed257f78d4fa','Related Links','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:55.250');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1041,0,-1,0,1,'-1,1041',2,'b6b73142-b9c1-4bf8-a16d-e1c23320b549','Tags','30a2a501-1978-4ddb-a57b-f7efed43ba3c','2006-01-03 13:07:55.250');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1042,0,-1,0,1,'-1,1042',0,'6affe356-cfbd-45ff-b0be-088705684704','Homepage','6fbde604-4178-42ce-a10b-8a2600a2f07d','2014-11-28 22:59:49.227');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1043,0,-1,0,1,'-1,1043',0,'ac23b667-558f-4766-ace7-e5152c9c0342','Starterkit Master','6fbde604-4178-42ce-a10b-8a2600a2f07d','2014-11-28 22:59:49.283');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1044,0,-1,0,1,'-1,1044',0,'bef98c54-95fe-4e7c-8a49-db7d0bbc955d','Textpage','6fbde604-4178-42ce-a10b-8a2600a2f07d','2014-11-28 22:59:49.310');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1045,0,-1,0,1,'-1,1045',0,'8d750909-30a9-4a2b-a8ba-995b4d65f8d0','Homepage','a2cb7800-f571-4787-9638-bc48539a0efb','2014-11-28 22:59:49.453');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1046,0,-1,0,1,'-1,1046',0,'2b4d0f4a-a49c-4526-ad0a-c900c1d21e5c','Textpage','a2cb7800-f571-4787-9638-bc48539a0efb','2014-11-28 22:59:49.607');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1047,0,-1,0,1,'-1,1047',0,'7258fe9a-f524-470f-99b9-c8f2e7b1bf44','Starterkit','9f68da4f-a3a8-44c2-8226-dcbd125e4840','2014-11-28 22:59:49.720');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1048,0,-1,0,1,'-1,1048',0,'b9f81f4a-b176-49f9-b810-57be7008693b','Simple website','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2008-05-02 09:52:36.000');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1049,0,1048,0,2,'-1,1048,1049',0,'8f5def86-31ad-4fab-aa1c-aeb43132ec3f','Installing modules','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2008-06-01 23:12:54.000');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1050,0,1048,0,2,'-1,1048,1050',1,'4a400af9-64e9-4afb-b910-eeb94cf3355e','Go further','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2008-06-01 23:14:52.000');
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (1051,0,1048,0,2,'-1,1048,1051',2,'dbc05390-ca07-45c7-a175-7648c4ad1ec2','Getting started','c66ba18e-eaf3-4cff-8a22-41b16d66a972','2008-06-01 23:11:56.000');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (1,0,-1,'2014-11-28 22:58:54.990','Debug','Republishing starting');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (2,0,-1,'2014-11-28 22:58:54.990','System','Loading content from database...');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (3,0,-1,'2014-11-28 22:58:55.000','Debug','Xml Pages loaded');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (4,0,-1,'2014-11-28 22:58:55.003','Debug','Done republishing Xml Index');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (5,0,-1,'2014-11-28 22:58:55.013','Debug','Xml saved in 00:00:00.0030983');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (6,0,-1,'2014-11-28 22:58:55.017','Debug','Xml saved in 00:00:00.0015989');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (7,0,-1,'2014-11-28 22:59:34.297','Login','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (8,0,-1,'2014-11-28 22:59:48.223','System','Log scrubbed.  Removed all items older than 2014-09-29 22:59:48');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (9,0,-1,'2014-11-28 22:59:49.087','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (10,0,-1,'2014-11-28 22:59:49.087','System','Loading content from disk cache...');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (11,0,1048,'2014-11-28 22:59:49.890','New','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (12,0,1049,'2014-11-28 22:59:49.993','New','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (13,0,1050,'2014-11-28 22:59:50.057','New','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (14,0,1051,'2014-11-28 22:59:50.120','New','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (15,0,-1,'2014-11-28 22:59:50.163','Debug','&lt;Action runat=&quot;install&quot; alias=&quot;publishRootDocument&quot; documentName=&quot;Simple website&quot; /&gt;');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (16,0,1048,'2014-11-28 22:59:50.210','Publish','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (17,0,1049,'2014-11-28 22:59:50.287','Publish','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (18,0,1050,'2014-11-28 22:59:50.340','Publish','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (19,0,1051,'2014-11-28 22:59:50.383','Publish','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (20,0,-1,'2014-11-28 22:59:50.470','System','Loading content from database...');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (21,0,-1,'2014-11-28 22:59:50.480','Debug','Xml Pages loaded');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (22,0,-1,'2014-11-28 22:59:50.480','Debug','Republishing starting');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (23,0,-1,'2014-11-28 22:59:50.490','Debug','Done republishing Xml Index');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (24,0,-1,'2014-11-28 22:59:50.490','Debug','Xml saved in 00:00:00.0066931');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (25,0,-1,'2014-11-28 22:59:50.497','Debug','Xml saved in 00:00:00.0061483');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (26,0,-1,'2014-11-28 23:00:09.673','System','Log scrubbed.  Removed all items older than 2014-09-29 23:00:09');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (27,0,-1,'2014-11-28 23:02:15.647','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (28,0,-1,'2014-11-28 23:02:17.307','System','Loading content from database...');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (29,0,-1,'2014-11-28 23:02:17.320','Debug','Republishing starting');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (30,0,-1,'2014-11-28 23:02:17.330','Debug','Xml Pages loaded');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (31,0,-1,'2014-11-28 23:02:17.330','Debug','Done republishing Xml Index');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (32,0,-1,'2014-11-28 23:02:17.337','Debug','Xml saved in 00:00:00.0020659');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (33,0,-1,'2014-11-28 23:02:17.340','Debug','Xml saved in 00:00:00.0019684');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (34,0,-1,'2014-11-28 23:02:17.613','System','Log scrubbed.  Removed all items older than 2014-09-29 23:02:17');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (35,0,-1,'2014-11-28 23:02:18.467','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (36,0,-1,'2014-11-28 23:02:19.533','System','Log scrubbed.  Removed all items older than 2014-09-29 23:02:19');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (37,0,-1,'2014-11-28 23:02:20.493','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (38,0,-1,'2014-11-28 23:02:31.893','System','Loading content from disk cache...');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (39,0,1048,'2014-11-28 23:03:06.827','Publish','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (40,0,1048,'2014-11-28 23:03:06.873','Publish','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (41,0,-1,'2014-11-28 23:03:06.910','System','Loading content from database...');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (42,0,-1,'2014-11-28 23:03:06.917','Debug','Xml Pages loaded');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (43,0,-1,'2014-11-28 23:03:06.917','Debug','Done republishing Xml Index');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (44,0,-1,'2014-11-28 23:03:06.923','Debug','Republishing starting');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (45,0,-1,'2014-11-28 23:03:06.927','Debug','Xml saved in 00:00:00.0051510');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (46,0,-1,'2014-11-28 23:03:06.927','Debug','Xml saved in 00:00:00.0019620');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (47,0,1048,'2014-11-28 23:05:12.993','Open','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (48,0,1049,'2014-11-28 23:05:21.713','Open','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (49,0,1050,'2014-11-28 23:05:22.797','Open','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (50,0,1051,'2014-11-28 23:05:23.810','Open','');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (51,0,-1,'2014-11-28 23:21:38.410','System','Log scrubbed.  Removed all items older than 2014-09-29 23:21:38');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (52,0,-1,'2014-11-28 23:21:39.597','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (53,0,-1,'2014-11-28 23:31:18.390','System','Log scrubbed.  Removed all items older than 2014-09-29 23:31:18');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (54,0,-1,'2014-11-28 23:31:40.897','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (55,0,-1,'2014-11-28 23:49:56.123','System','Log scrubbed.  Removed all items older than 2014-09-29 23:49:56');
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (56,0,-1,'2014-11-28 23:50:00.593','Custom','[UmbracoExamine] Adding examine event handlers for index providers: 3');
INSERT INTO [umbracoLanguage] ([id],[languageISOCode],[languageCultureName]) VALUES (1,'en-US','en-US');
INSERT INTO [cmsTemplate] ([pk],[nodeId],[master],[alias],[design]) VALUES (1,1042,1043,'umbHomepage','<%@ Master Language="C#" MasterPageFile="~/masterpages/umbMaster.master" AutoEventWireup="true" %>
<asp:Content ContentPlaceHolderID="cp_content" runat="server">
  <div id="content" class="frontPage">
    <umbraco:Item runat="server" field="bodyText"/>
  </div>
</asp:Content>');
INSERT INTO [cmsTemplate] ([pk],[nodeId],[master],[alias],[design]) VALUES (2,1043,NULL,'umbMaster','<%@ Master Language="C#" MasterPageFile="~/umbraco/masterpages/default.master" AutoEventWireup="true" %>
<asp:Content ContentPlaceHolderID="ContentPlaceHolderDefault" runat="server">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"[]> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head id="head" runat="server">
    
  
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <title><asp:placeholder runat="server"><umbraco:Item runat="server" field="pageName" /> - <umbraco:Item runat="server" field="siteName" recursive="true" /></asp:placeholder></title>
    
  <link rel="stylesheet" type="text/css" href="/css/Starterkit.css" /> 
  
  <umbraco:Macro Alias="BlogRssFeedLink" runat="server"></umbraco:Macro>
    
  <asp:contentplaceholder id="cp_head" runat="server" />
</head>
  <body>    
    <div id="main">
      
      <asp:contentplaceholder id="cp_top" runat="server">
        <div id="top">
          <h1 id="siteName"><a href="/"><umbraco:Item runat="server" field="siteName" recursive="true" /></a></h1>
          <h2 id="siteDescription"><umbraco:Item runat="server" field="siteDescription" recursive="true" /></h2>
        
          <umbraco:Macro Alias="umbTopNavigation" runat="server" />
        </div>
      </asp:contentplaceholder>
            
      <div id="body" class="clearfix">
          <form id="RunwayMasterForm" runat="server">
            <asp:ContentPlaceHolder ID="cp_content" runat="server"></asp:ContentPlaceHolder>
          </form>
      </div> 
      
      <asp:contentplaceholder id="cp_footer" runat="server">
        <div id="footer"></div>
      </asp:contentplaceholder>
    </div>
  </body>
</html> 
</asp:content>');
INSERT INTO [cmsTemplate] ([pk],[nodeId],[master],[alias],[design]) VALUES (3,1044,1043,'umbTextpage','<%@ Master Language="C#" MasterPageFile="~/masterpages/umbMaster.master" AutoEventWireup="true" %>
<asp:Content ContentPlaceHolderID="cp_content" runat="server">

<div id="content" class="textpage">
  
      <div id="contentHeader">  
          <h2><umbraco:Item runat="server" field="pageName"/></h2>
      </div>
      
      <umbraco:Item runat="server" field="bodyText" />
</div>

<div id="subNavigation">
      <umbraco:Macro Alias="umb2ndLevelNavigation" runat="server"></umbraco:Macro>
</div>
  

</asp:Content>');
INSERT INTO [cmsTaskType] ([id],[alias]) VALUES (1,'toTranslate');
INSERT INTO [cmsTab] ([id],[contenttypeNodeId],[text],[sortorder]) VALUES (3,1032,'Image',1);
INSERT INTO [cmsTab] ([id],[contenttypeNodeId],[text],[sortorder]) VALUES (4,1033,'File',1);
INSERT INTO [cmsTab] ([id],[contenttypeNodeId],[text],[sortorder]) VALUES (5,1031,'Contents',1);
INSERT INTO [cmsTab] ([id],[contenttypeNodeId],[text],[sortorder]) VALUES (6,1045,'Site',1);
INSERT INTO [cmsTab] ([id],[contenttypeNodeId],[text],[sortorder]) VALUES (7,1045,'Content',2);
INSERT INTO [cmsTab] ([id],[contenttypeNodeId],[text],[sortorder]) VALUES (8,1046,'Content',1);
INSERT INTO [cmsStylesheet] ([nodeId],[filename],[content]) VALUES (1047,'','/*LAYOUT*/

body{text-align: left; padding: 0px; margin: 0px; background: #F6F7F9;}

#main{margin: auto; margin-top: 20px; text-align: left; width: 870px;}

#top{border-bottom: 1px solid #CED7DE;}

#top ul{list-style: none; padding: 0px 0px 15px 0px; margin: 0px;}
#top ul li{display: inline; margin: 0px; padding: 0xp;}
#top ul li a{padding: 10px 20px 10px 0px; color: #000}

#top ul li.current a{font-weight: bold}

#body{margin: auto; padding: 2em 0em 2em 0em;}
#footer{padding-top: 5px; clear: both;}

/* Subpages layout */
#content.textpage{text-align: left; float: left; width: 75%;}
#subNavigation{margin-top: 40px; width: 22%; float: right;} 
#subNavigation ul{list-style: none; border: 1px solid #FFE8CD; background: #FFF9D8; display: block; padding: 10px; padding-left: 0px;}
#subNavigation ul li{margin: 0; padding: 0px; padding-right: 10px;}

/* FONTS standards */
body {font-size: 14px; background:#fff; font-family: "Lucida Grande", Arial, sans-serif;}

h1, h2, h3, h4, h5, h6 {color: #426FC8; font-weight: 500;}
h1 {font-size:60px; line-height: 1; margin-bottom:0.5em; font-weight: bold; letter-spacing: -1px; width: auto; color: #666;}
h2 {font-size:25px; margin-bottom:0.75em;}

h3 {font-size: 18px;line-height:1;margin-bottom:1em;}
h4 {font-size:1.2em;line-height:1.25;margin-bottom:1.25em;}
h5 {font-size:1em;font-weight:bold;margin-bottom:1.5em;}
h6 {font-size:1em;font-weight:bold;}
h1 img, h2 img, h3 img, h4 img, h5 img, h6 img {margin:0;}

p {margin:0 0 1.5em; font-size: 16px;}
p img {float:left;margin:1.5em 1.5em 1.5em 0;padding:0;}
p img.right {float:right;margin:1.5em 0 1.5em 1.5em;}

/* LINKS standards */
a:hover {color:#000;}
a {color: #426FC8; text-decoration:underline;}
h1 a{color: #666; text-decoration: none;}

/* ELEMENTS standards */
blockquote {margin:1.5em;color:#666;font-style:italic;}
strong {font-weight:bold;}
em, dfn {font-style:italic;}
dfn {font-weight:bold;}
sup, sub {line-height:0;}
abbr, acronym {border-bottom:1px dotted #666;}
address {margin:0 0 1.5em;font-style:italic;}
del {color:#666;}
pre, code {margin:1.5em 0;white-space:pre;}
pre, code, tt {font:1em ''andale mono'', ''lucida console'', monospace;line-height:1.5;}
li ul, li ol {margin:0 1.5em;}
ul, ol {margin:0 1.5em 1.5em 1.5em;}
ul {list-style-type:disc;}
ol {list-style-type:decimal;}
dl {margin:0 0 1.5em 0;}
dl dt {font-weight:bold;}
dd {margin-left:1.5em;}
table {margin-bottom:1.4em;width:100%;}
th {font-weight:bold;background:#C3D9FF;}
th, td {padding:4px 10px 4px 5px;}
tr.even td {background:#E5ECF9;}
tfoot {font-style:italic;}
caption {background:#eee;}

/* FORM ELEMENTS */
label {font-weight:bold;}
fieldset {padding:1.4em;margin:0 0 1.5em 0;border:1px solid #ccc;}
legend {font-weight:bold;font-size:1.2em;}
input.text, input.title, textarea, select {margin:0.5em 0;border:1px solid #bbb;}
input.text:focus, input.title:focus, textarea:focus, select:focus {border:1px solid #666;}
input.text, input.title {width:300px;padding:5px;}
input.title {font-size:1.5em;}
textarea {width:300px;height:250px;padding:5px;}
.error, .notice, .success {padding:.8em;margin-bottom:1em;border:2px solid #ddd;}
.error {background:#FBE3E4;color:#8a1f11;border-color:#FBC2C4;}
.notice {background:#FFF6BF;color:#514721;border-color:#FFD324;}
.success {background:#E6EFC2;color:#264409;border-color:#C6D880;}
.error a {color:#8a1f11;}
.notice a {color:#514721;}
.success a {color:#264409;}

.error ul{margin-bottom: 0; padding-bottom: 0;}


/*BLOG STYLES */
#content .post{text-align: left;}

/* Clear fix to repleace br clear:both */ 
.clearfix:after {
  content: ".";
  display: block;
  clear: both;
  visibility: hidden;
  line-height: 0;
  height: 0;
}
 
.clearfix {
  display: inline-block;
}
 
html[xmlns] .clearfix {
  display: block;
}
 
* html .clearfix {
  height: 1%;
}





















































');
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (6,-90,1032,3,'umbracoFile','Upload image',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (7,-92,1032,3,'umbracoWidth','Width',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (8,-92,1032,3,'umbracoHeight','Height',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (9,-92,1032,3,'umbracoBytes','Size',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (10,-92,1032,3,'umbracoExtension','Type',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (24,-90,1033,4,'umbracoFile','Upload file',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (25,-92,1033,4,'umbracoExtension','Type',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (26,-92,1033,4,'umbracoBytes','Size',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (27,-38,1031,5,'contents','Contents:',NULL,0,0,NULL,NULL);
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (28,-87,1045,7,'bodyText','Body text',NULL,0,0,'','');
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (29,-88,1045,6,'siteName','Site Name',NULL,0,0,'','');
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (30,-89,1045,6,'siteDescription','Site Description',NULL,0,0,'','');
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (31,-87,1046,8,'bodyText','Body Text',NULL,0,0,'','');
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[tabId],[Alias],[Name],[helpText],[sortOrder],[mandatory],[validationRegExp],[Description]) VALUES (32,-49,1046,NULL,'umbracoNaviHide','Hide in navigation',NULL,0,0,'','');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (1,1048,'2b7d45e1-ffce-4082-a9cf-a769d9ffd130',28,NULL,NULL,NULL,'
<p>The Simple Starter Kit gives you a bare-bones website that
introduces you to a set of well-defined conventions for building an
Umbraco website.</p>

<p>The Simple website is very basic in form and provided without
any design or functionality - unless you add a Skin, of course. By
installing the Simple Starter Kit, you''ll begin with a minimal site
built on best practices. You''ll also enjoy the benefits of speaking
the same "language" as the rest of the Umbraco community by using
common properties and naming conventions.</p>

<p>Now that you know what the Simple site is, it is time to get
started using Umbraco.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (2,1048,'2b7d45e1-ffce-4082-a9cf-a769d9ffd130',29,NULL,NULL,'Simple website',NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (3,1048,'2b7d45e1-ffce-4082-a9cf-a769d9ffd130',30,NULL,NULL,NULL,'Off to a great start');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (4,1049,'7f42a15e-8125-492b-b092-35b6ccef1e2d',31,NULL,NULL,NULL,'
<p>Umbraco modules encapsulate specific bits of advanced
functionality that are easily added to your website.</p>

<p>Once installed, Umbraco modules are open source and easy to
customize if you want to modify the behavior for your specific
needs.<br />
 Because Umbraco modules are provided under the MIT license you are
free to use and modify them any way you want, with no strings
attached.</p>

<p>To add Umbraco modules to your website, go to the
<strong>Settings</strong> section, expand the
<strong>Templates</strong> item, select the <strong>Starterkit
Master</strong> template, then click the <strong>Customize
Skin</strong> button on the toolbar.</p>

<p>Umbraco modules are available for various kinds of navigation, a
sitemap, social media feeds, and a contact form. The list of
available Umbraco modules is growing rapidly and is automatically
updated from a central source, always fresh and current.</p>

<p><a href="http://umbraco.org/get-started"
title="Get Started with Umbraco">Get more information</a> about the
umbraco way.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (5,1049,'7f42a15e-8125-492b-b092-35b6ccef1e2d',32,0,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (6,1050,'6bdbf441-dc94-4154-977b-dd6cd4ecad01',31,NULL,NULL,NULL,'
<p>The Simple Starter Kit only scratches the surface of what''s
possible with Umbraco. Below the Simple Starter Kit and its modules
lies a great architecture that lets you implement whatever you
need.</p>

<p>With Umbraco you''ve finally got a solid, open and reliable
platform for websites as basic as the Simple site, and Umbraco can
be rapidly expanded to support multi-language websites,
collaboration platforms and intra/extranets, to name just a
few.</p>

<p>Advanced functionality is created with Umbraco macros, built
with XSLT and Umbraco''s award-winning .NET integration, including
full support for any .NET User or Custom control. Create and
integrate your own .NET macros in mere minutes with point and click
simplicity. Simply copy your controls to the Umbraco website, go to
the <strong>Developer</strong> section and create a new macro,
selecting your control from the list.</p>

<p>You can also use <a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started/working-with-webmatrix"
 title="Working with Razor">Microsoft''s Razor</a> syntax to quickly
add dynamic functionality to your site.</p>

<p>We''ve also gathered the best community macros into a repository
that''s also accessed from the <strong>Developer</strong> section,
in the <strong>Packages</strong> area. You can find more
information <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/what-are-macros"
 title="About creating Umbraco macros">about creating macros</a>,
on the Umbraco website.</p>

<p>The sky is the limit with Umbraco, and you have the benefit a
friendly community, training, and guaranteed support. Find out how
to <a href="http://umbraco.org/help-and-support"
title="Get Umbraco Support">get help</a>.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (7,1050,'6bdbf441-dc94-4154-977b-dd6cd4ecad01',32,0,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (8,1051,'2544835f-bd40-4693-9afd-3f1d9558d292',31,NULL,NULL,NULL,'
<p>You''ve installed Umbraco and the basic Simple website.</p>

<p>Edit the text on the homepage and create a site structure by
adding new texpages to your site. This is all done in the
<strong>Content</strong> section.</p>

<p>If you find the editing options provided by the Simple site too
limited for you needs, simply add more properties to the page by
going to the <strong>Settings</strong> section, expanding the
<strong>Document Types</strong> item and adding new properties on
the <strong>Generic Properties</strong> tab. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/document-types"
 title="About Umbraco Document Types">document types and
properties</a> at the <a href="http://umbraco.org"
title="The Umbraco Website">Umbraco website</a>.</p>

<p>You''ll probably want to personalize your site by changing the
current design. This is also done in the <strong>Settings</strong>
section, either by editing the CSS styles and HTML templates or by
selecting and applying a Skin. Umbraco uses master templates, so
the main, common markup is placed in the <strong>Starterkit
Master</strong> template, while the Homeage and Textpage have
separate templates for their unique layouts. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/templates"
 title="Umbraco Templates and Stylesheets">templates and css</a> in
umbraco at the umbraco website.</p>

<p>Once you''re happy with your site''s design, you might want to add
more functionality, such as automated navigation. This is done by
<a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started"
 title="Umbraco Modules">installing Umbraco modules</a>.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (9,1051,'2544835f-bd40-4693-9afd-3f1d9558d292',32,0,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (10,1048,'c8438d5b-ec6d-4f1f-9621-d531ed9962fe',28,NULL,NULL,NULL,'
<p>The Simple Starter Kit gives you a bare-bones website that
introduces you to a set of well-defined conventions for building an
Umbraco website.</p>

<p>The Simple website is very basic in form and provided without
any design or functionality - unless you add a Skin, of course. By
installing the Simple Starter Kit, you''ll begin with a minimal site
built on best practices. You''ll also enjoy the benefits of speaking
the same "language" as the rest of the Umbraco community by using
common properties and naming conventions.</p>

<p>Now that you know what the Simple site is, it is time to get
started using Umbraco.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (11,1048,'c8438d5b-ec6d-4f1f-9621-d531ed9962fe',29,NULL,NULL,'',NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (12,1048,'c8438d5b-ec6d-4f1f-9621-d531ed9962fe',30,NULL,NULL,NULL,'Off to a great start');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (13,1049,'bc7bbbef-94a3-472c-91c5-fad8c153657a',31,NULL,NULL,NULL,'
<p>Umbraco modules encapsulate specific bits of advanced
functionality that are easily added to your website.</p>

<p>Once installed, Umbraco modules are open source and easy to
customize if you want to modify the behavior for your specific
needs.<br />
 Because Umbraco modules are provided under the MIT license you are
free to use and modify them any way you want, with no strings
attached.</p>

<p>To add Umbraco modules to your website, go to the
<strong>Settings</strong> section, expand the
<strong>Templates</strong> item, select the <strong>Starterkit
Master</strong> template, then click the <strong>Customize
Skin</strong> button on the toolbar.</p>

<p>Umbraco modules are available for various kinds of navigation, a
sitemap, social media feeds, and a contact form. The list of
available Umbraco modules is growing rapidly and is automatically
updated from a central source, always fresh and current.</p>

<p><a href="http://umbraco.org/get-started"
title="Get Started with Umbraco">Get more information</a> about the
umbraco way.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (14,1049,'bc7bbbef-94a3-472c-91c5-fad8c153657a',32,0,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (15,1050,'1bf77d6e-23da-479f-b180-4fdc0a2bafac',31,NULL,NULL,NULL,'
<p>The Simple Starter Kit only scratches the surface of what''s
possible with Umbraco. Below the Simple Starter Kit and its modules
lies a great architecture that lets you implement whatever you
need.</p>

<p>With Umbraco you''ve finally got a solid, open and reliable
platform for websites as basic as the Simple site, and Umbraco can
be rapidly expanded to support multi-language websites,
collaboration platforms and intra/extranets, to name just a
few.</p>

<p>Advanced functionality is created with Umbraco macros, built
with XSLT and Umbraco''s award-winning .NET integration, including
full support for any .NET User or Custom control. Create and
integrate your own .NET macros in mere minutes with point and click
simplicity. Simply copy your controls to the Umbraco website, go to
the <strong>Developer</strong> section and create a new macro,
selecting your control from the list.</p>

<p>You can also use <a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started/working-with-webmatrix"
 title="Working with Razor">Microsoft''s Razor</a> syntax to quickly
add dynamic functionality to your site.</p>

<p>We''ve also gathered the best community macros into a repository
that''s also accessed from the <strong>Developer</strong> section,
in the <strong>Packages</strong> area. You can find more
information <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/what-are-macros"
 title="About creating Umbraco macros">about creating macros</a>,
on the Umbraco website.</p>

<p>The sky is the limit with Umbraco, and you have the benefit a
friendly community, training, and guaranteed support. Find out how
to <a href="http://umbraco.org/help-and-support"
title="Get Umbraco Support">get help</a>.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (16,1050,'1bf77d6e-23da-479f-b180-4fdc0a2bafac',32,0,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (17,1051,'6d9189da-4d1f-4e60-9380-f9956de3cdec',31,NULL,NULL,NULL,'
<p>You''ve installed Umbraco and the basic Simple website.</p>

<p>Edit the text on the homepage and create a site structure by
adding new texpages to your site. This is all done in the
<strong>Content</strong> section.</p>

<p>If you find the editing options provided by the Simple site too
limited for you needs, simply add more properties to the page by
going to the <strong>Settings</strong> section, expanding the
<strong>Document Types</strong> item and adding new properties on
the <strong>Generic Properties</strong> tab. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/document-types"
 title="About Umbraco Document Types">document types and
properties</a> at the <a href="http://umbraco.org"
title="The Umbraco Website">Umbraco website</a>.</p>

<p>You''ll probably want to personalize your site by changing the
current design. This is also done in the <strong>Settings</strong>
section, either by editing the CSS styles and HTML templates or by
selecting and applying a Skin. Umbraco uses master templates, so
the main, common markup is placed in the <strong>Starterkit
Master</strong> template, while the Homeage and Textpage have
separate templates for their unique layouts. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/templates"
 title="Umbraco Templates and Stylesheets">templates and css</a> in
umbraco at the umbraco website.</p>

<p>Once you''re happy with your site''s design, you might want to add
more functionality, such as automated navigation. This is done by
<a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started"
 title="Umbraco Modules">installing Umbraco modules</a>.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (18,1051,'6d9189da-4d1f-4e60-9380-f9956de3cdec',32,0,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (19,1048,'08cebd7a-79de-4fbd-91cc-851a22a8f9ed',28,NULL,NULL,NULL,'
<p>The Simple Starter Kit gives you a bare-bones website that
introduces you to a set of well-defined conventions for building an
Umbraco website.</p>

<p>The Simple website is very basic in form and provided without
any design or functionality - unless you add a Skin, of course. By
installing the Simple Starter Kit, you''ll begin with a minimal site
built on best practices. You''ll also enjoy the benefits of speaking
the same "language" as the rest of the Umbraco community by using
common properties and naming conventions.</p>

<p>Now that you know what the Simple site is, it is time to get
started using Umbraco.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (20,1048,'08cebd7a-79de-4fbd-91cc-851a22a8f9ed',29,NULL,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (21,1048,'08cebd7a-79de-4fbd-91cc-851a22a8f9ed',30,NULL,NULL,NULL,'');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (22,1048,'a6a8297f-5935-4f0e-9874-948fcf79b83b',28,NULL,NULL,NULL,'
<p>The Simple Starter Kit gives you a bare-bones website that
introduces you to a set of well-defined conventions for building an
Umbraco website.</p>

<p>The Simple website is very basic in form and provided without
any design or functionality - unless you add a Skin, of course. By
installing the Simple Starter Kit, you''ll begin with a minimal site
built on best practices. You''ll also enjoy the benefits of speaking
the same "language" as the rest of the Umbraco community by using
common properties and naming conventions.</p>

<p>Now that you know what the Simple site is, it is time to get
started using Umbraco.</p>
');
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (23,1048,'a6a8297f-5935-4f0e-9874-948fcf79b83b',29,NULL,NULL,NULL,NULL);
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDate],[dataNvarchar],[dataNtext]) VALUES (24,1048,'a6a8297f-5935-4f0e-9874-948fcf79b83b',30,NULL,NULL,NULL,NULL);
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (1048,'2b7d45e1-ffce-4082-a9cf-a769d9ffd130','2014-11-28 22:59:49.967','<umbHomepage id="1048" parentID="-1" level="1" writerID="0" creatorID="0" nodeType="1045" template="1042" sortOrder="0" createDate="2008-05-02T09:52:36" updateDate="2014-11-28T22:59:49" nodeName="Simple website" urlName="simple-website" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048" isDoc=""><bodyText><![CDATA[
<p>The Simple Starter Kit gives you a bare-bones website that
introduces you to a set of well-defined conventions for building an
Umbraco website.</p>

<p>The Simple website is very basic in form and provided without
any design or functionality - unless you add a Skin, of course. By
installing the Simple Starter Kit, you''ll begin with a minimal site
built on best practices. You''ll also enjoy the benefits of speaking
the same "language" as the rest of the Umbraco community by using
common properties and naming conventions.</p>

<p>Now that you know what the Simple site is, it is time to get
started using Umbraco.</p>
]]></bodyText><siteName>Simple website</siteName><siteDescription><![CDATA[Off to a great start]]></siteDescription></umbHomepage>');
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (1049,'7f42a15e-8125-492b-b092-35b6ccef1e2d','2014-11-28 22:59:50.030','<umbTextpage id="1049" parentID="1048" level="2" writerID="0" creatorID="0" nodeType="1046" template="1044" sortOrder="0" createDate="2008-06-01T23:12:54" updateDate="2014-11-28T22:59:49" nodeName="Installing modules" urlName="installing-modules" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048,1049" isDoc=""><bodyText><![CDATA[
<p>Umbraco modules encapsulate specific bits of advanced
functionality that are easily added to your website.</p>

<p>Once installed, Umbraco modules are open source and easy to
customize if you want to modify the behavior for your specific
needs.<br />
 Because Umbraco modules are provided under the MIT license you are
free to use and modify them any way you want, with no strings
attached.</p>

<p>To add Umbraco modules to your website, go to the
<strong>Settings</strong> section, expand the
<strong>Templates</strong> item, select the <strong>Starterkit
Master</strong> template, then click the <strong>Customize
Skin</strong> button on the toolbar.</p>

<p>Umbraco modules are available for various kinds of navigation, a
sitemap, social media feeds, and a contact form. The list of
available Umbraco modules is growing rapidly and is automatically
updated from a central source, always fresh and current.</p>

<p><a href="http://umbraco.org/get-started"
title="Get Started with Umbraco">Get more information</a> about the
umbraco way.</p>
]]></bodyText><umbracoNaviHide>0</umbracoNaviHide></umbTextpage>');
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (1050,'6bdbf441-dc94-4154-977b-dd6cd4ecad01','2014-11-28 22:59:50.093','<umbTextpage id="1050" parentID="1048" level="2" writerID="0" creatorID="0" nodeType="1046" template="1044" sortOrder="1" createDate="2008-06-01T23:14:52" updateDate="2014-11-28T22:59:50" nodeName="Go further" urlName="go-further" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048,1050" isDoc=""><bodyText><![CDATA[
<p>The Simple Starter Kit only scratches the surface of what''s
possible with Umbraco. Below the Simple Starter Kit and its modules
lies a great architecture that lets you implement whatever you
need.</p>

<p>With Umbraco you''ve finally got a solid, open and reliable
platform for websites as basic as the Simple site, and Umbraco can
be rapidly expanded to support multi-language websites,
collaboration platforms and intra/extranets, to name just a
few.</p>

<p>Advanced functionality is created with Umbraco macros, built
with XSLT and Umbraco''s award-winning .NET integration, including
full support for any .NET User or Custom control. Create and
integrate your own .NET macros in mere minutes with point and click
simplicity. Simply copy your controls to the Umbraco website, go to
the <strong>Developer</strong> section and create a new macro,
selecting your control from the list.</p>

<p>You can also use <a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started/working-with-webmatrix"
 title="Working with Razor">Microsoft''s Razor</a> syntax to quickly
add dynamic functionality to your site.</p>

<p>We''ve also gathered the best community macros into a repository
that''s also accessed from the <strong>Developer</strong> section,
in the <strong>Packages</strong> area. You can find more
information <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/what-are-macros"
 title="About creating Umbraco macros">about creating macros</a>,
on the Umbraco website.</p>

<p>The sky is the limit with Umbraco, and you have the benefit a
friendly community, training, and guaranteed support. Find out how
to <a href="http://umbraco.org/help-and-support"
title="Get Umbraco Support">get help</a>.</p>
]]></bodyText><umbracoNaviHide>0</umbracoNaviHide></umbTextpage>');
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (1051,'2544835f-bd40-4693-9afd-3f1d9558d292','2014-11-28 22:59:50.160','<umbTextpage id="1051" parentID="1048" level="2" writerID="0" creatorID="0" nodeType="1046" template="1044" sortOrder="2" createDate="2008-06-01T23:11:56" updateDate="2014-11-28T22:59:50" nodeName="Getting started" urlName="getting-started" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048,1051" isDoc=""><bodyText><![CDATA[
<p>You''ve installed Umbraco and the basic Simple website.</p>

<p>Edit the text on the homepage and create a site structure by
adding new texpages to your site. This is all done in the
<strong>Content</strong> section.</p>

<p>If you find the editing options provided by the Simple site too
limited for you needs, simply add more properties to the page by
going to the <strong>Settings</strong> section, expanding the
<strong>Document Types</strong> item and adding new properties on
the <strong>Generic Properties</strong> tab. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/document-types"
 title="About Umbraco Document Types">document types and
properties</a> at the <a href="http://umbraco.org"
title="The Umbraco Website">Umbraco website</a>.</p>

<p>You''ll probably want to personalize your site by changing the
current design. This is also done in the <strong>Settings</strong>
section, either by editing the CSS styles and HTML templates or by
selecting and applying a Skin. Umbraco uses master templates, so
the main, common markup is placed in the <strong>Starterkit
Master</strong> template, while the Homeage and Textpage have
separate templates for their unique layouts. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/templates"
 title="Umbraco Templates and Stylesheets">templates and css</a> in
umbraco at the umbraco website.</p>

<p>Once you''re happy with your site''s design, you might want to add
more functionality, such as automated navigation. This is done by
<a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started"
 title="Umbraco Modules">installing Umbraco modules</a>.</p>
]]></bodyText><umbracoNaviHide>0</umbracoNaviHide></umbTextpage>');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (3,'mediaCurrent','umbraco.macroRenderings','media','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (4,'contentSubs','umbraco.macroRenderings','content','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (5,'contentRandom','umbraco.macroRenderings','content','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (6,'contentPicker','umbraco.macroRenderings','content','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (13,'number','umbraco.macroRenderings','numeric','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (14,'bool','umbraco.macroRenderings','yesNo','Boolean');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (16,'text','umbraco.macroRenderings','text','String');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (17,'contentTree','umbraco.macroRenderings','content','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (18,'contentType','umbraco.macroRenderings','contentTypeSingle','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (19,'contentTypeMultiple','umbraco.macroRenderings','contentTypeMultiple','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (20,'contentAll','umbraco.macroRenderings','content','Int32');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (21,'tabPicker','umbraco.macroRenderings','tabPicker','String');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (22,'tabPickerMultiple','umbraco.macroRenderings','tabPickerMultiple','String');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (23,'propertyTypePicker','umbraco.macroRenderings','propertyTypePicker','String');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (24,'propertyTypePickerMultiple','umbraco.macroRenderings','propertyTypePickerMultiple','String');
INSERT INTO [cmsMacroPropertyType] ([id],[macroPropertyTypeAlias],[macroPropertyTypeRenderAssembly],[macroPropertyTypeRenderType],[macroPropertyTypeBaseType]) VALUES (25,'textMultiLine','umbraco.macroRenderings','textMultiple','String');
INSERT INTO [cmsMacro] ([id],[macroUseInEditor],[macroRefreshRate],[macroAlias],[macroName],[macroScriptType],[macroScriptAssembly],[macroXSLT],[macroCacheByPage],[macroCachePersonalized],[macroDontRender],[macroPython]) VALUES (1,0,0,'umb2ndLevelNavigation','2nd Level Navigation','','','umb2ndLevelNavigation.xslt',1,0,0,'');
INSERT INTO [cmsMacro] ([id],[macroUseInEditor],[macroRefreshRate],[macroAlias],[macroName],[macroScriptType],[macroScriptAssembly],[macroXSLT],[macroCacheByPage],[macroCachePersonalized],[macroDontRender],[macroPython]) VALUES (2,0,0,'umbTopNavigation','Top Navigation','','','umbTopNavigation.xslt',1,0,0,'');
INSERT INTO [cmsDocumentType] ([contentTypeNodeId],[templateNodeId],[IsDefault]) VALUES (1045,1042,1);
INSERT INTO [cmsDocumentType] ([contentTypeNodeId],[templateNodeId],[IsDefault]) VALUES (1046,1044,1);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1049,1,0,'7f42a15e-8125-492b-b092-35b6ccef1e2d','Installing modules',NULL,NULL,'2014-11-28 22:59:50.020',NULL,NULL,0);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1051,1,0,'2544835f-bd40-4693-9afd-3f1d9558d292','Getting started',NULL,NULL,'2014-11-28 22:59:50.150',NULL,NULL,0);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1050,0,0,'1bf77d6e-23da-479f-b180-4fdc0a2bafac','Go further',NULL,NULL,'2014-11-28 22:59:50.327',1044,NULL,1);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1048,1,0,'08cebd7a-79de-4fbd-91cc-851a22a8f9ed','Simple website',NULL,NULL,'2014-11-28 23:03:06.810',1042,NULL,0);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1048,0,0,'a6a8297f-5935-4f0e-9874-948fcf79b83b','Simple website',NULL,NULL,'2014-11-28 23:03:06.863',1042,NULL,1);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1048,0,0,'2b7d45e1-ffce-4082-a9cf-a769d9ffd130','Simple website',NULL,NULL,'2014-11-28 22:59:49.963',NULL,NULL,0);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1048,0,0,'c8438d5b-ec6d-4f1f-9621-d531ed9962fe','Simple website',NULL,NULL,'2014-11-28 22:59:50.190',1042,NULL,0);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1050,1,0,'6bdbf441-dc94-4154-977b-dd6cd4ecad01','Go further',NULL,NULL,'2014-11-28 22:59:50.087',NULL,NULL,0);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1051,0,0,'6d9189da-4d1f-4e60-9380-f9956de3cdec','Getting started',NULL,NULL,'2014-11-28 22:59:50.373',1044,NULL,1);
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[alias],[newest]) VALUES (1049,0,0,'bc7bbbef-94a3-472c-91c5-fad8c153657a','Installing modules',NULL,NULL,'2014-11-28 22:59:50.273',1044,NULL,1);
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (3,-87,',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|',0,'');
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (4,1041,'default',0,'group');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (4,-49,'38b352c1-e9f8-4fd8-9324-9a2eab06d97a','Integer');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (6,-51,'1413afcb-d19a-4173-8e9a-68288d2a73b8','Integer');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (8,-87,'5e9b75ae-face-41c8-b47e-5f4b0fd82f83','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (9,-88,'ec15c1e5-9d90-422a-aa52-4f7622c63bea','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (10,-89,'67db8357-ef57-493e-91ac-936d305e0f2a','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (11,-90,'5032a6e6-69e3-491d-bb28-cd31cd11086c','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (12,-91,'a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (13,-92,'6c738306-4c17-4d88-b9bd-6546f3771597','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (14,-36,'b6fb1622-afa5-4bbf-a3cc-d9672a442222','Date');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (15,-37,'f8d60f68-ec59-4974-b43b-c46eb5677985','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (16,-38,'cccd4ae9-f399-4ed2-8038-2e88d19e810c','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (17,-39,'928639ed-9c73-4028-920c-1e55dbb68783','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (18,-40,'a52c7c1c-c330-476e-8605-d63d3b84b6a6','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (19,-41,'23e93522-3200-44e2-9f29-e61a6fcbb79a','Date');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (20,-42,'a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6','Integer');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (21,-43,'b4471851-82b6-4c75-afa4-39fa9c6a75e9','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (22,-44,'a3776494-0574-4d93-b7de-efdfdec6f2d1','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (23,-128,'a52c7c1c-c330-476e-8605-d63d3b84b6a6','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (24,-129,'928639ed-9c73-4028-920c-1e55dbb68783','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (25,-130,'a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (26,-131,'a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (27,-132,'a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (28,-133,'6c738306-4c17-4d88-b9bd-6546f3771597','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (29,-134,'928639ed-9c73-4028-920c-1e55dbb68783','Nvarchar');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (30,-50,'aaf99bb2-dbbe-444d-a296-185076bf0484','Date');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (31,1034,'158aa029-24ed-4948-939e-c3da209e5fba','Integer');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (32,1035,'ead69342-f06d-4253-83ac-28000225583b','Integer');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (33,1036,'39f533e4-0551-4505-a64b-e0425c5ce775','Integer');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (35,1038,'60b7dabf-99cd-41eb-b8e9-4d2e669bbde9','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (36,1039,'cdbf0b5d-5cb2-445f-bc12-fcaaec07cf2c','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (37,1040,'71b8ad1a-8dc2-425c-b6b8-faa158075e63','Ntext');
INSERT INTO [cmsDataType] ([pk],[nodeId],[controlId],[dbType]) VALUES (38,1041,'4023e540-92f5-11dd-ad8b-0800200c9a66','Ntext');
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (1048,'<umbHomepage id="1048" parentID="-1" level="1" writerID="0" creatorID="0" nodeType="1045" template="1042" sortOrder="0" createDate="2008-05-02T09:52:36" updateDate="2014-11-28T23:03:06" nodeName="Simple website" urlName="simple-website" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048" isDoc=""><bodyText><![CDATA[
<p>The Simple Starter Kit gives you a bare-bones website that
introduces you to a set of well-defined conventions for building an
Umbraco website.</p>

<p>The Simple website is very basic in form and provided without
any design or functionality - unless you add a Skin, of course. By
installing the Simple Starter Kit, you''ll begin with a minimal site
built on best practices. You''ll also enjoy the benefits of speaking
the same "language" as the rest of the Umbraco community by using
common properties and naming conventions.</p>

<p>Now that you know what the Simple site is, it is time to get
started using Umbraco.</p>
]]></bodyText><siteName></siteName><siteDescription><![CDATA[]]></siteDescription></umbHomepage>');
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (1049,'<umbTextpage id="1049" parentID="1048" level="2" writerID="0" creatorID="0" nodeType="1046" template="1044" sortOrder="0" createDate="2008-06-01T23:12:54" updateDate="2014-11-28T22:59:50" nodeName="Installing modules" urlName="installing-modules" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048,1049" isDoc=""><bodyText><![CDATA[
<p>Umbraco modules encapsulate specific bits of advanced
functionality that are easily added to your website.</p>

<p>Once installed, Umbraco modules are open source and easy to
customize if you want to modify the behavior for your specific
needs.<br />
 Because Umbraco modules are provided under the MIT license you are
free to use and modify them any way you want, with no strings
attached.</p>

<p>To add Umbraco modules to your website, go to the
<strong>Settings</strong> section, expand the
<strong>Templates</strong> item, select the <strong>Starterkit
Master</strong> template, then click the <strong>Customize
Skin</strong> button on the toolbar.</p>

<p>Umbraco modules are available for various kinds of navigation, a
sitemap, social media feeds, and a contact form. The list of
available Umbraco modules is growing rapidly and is automatically
updated from a central source, always fresh and current.</p>

<p><a href="http://umbraco.org/get-started"
title="Get Started with Umbraco">Get more information</a> about the
umbraco way.</p>
]]></bodyText><umbracoNaviHide>0</umbracoNaviHide></umbTextpage>');
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (1050,'<umbTextpage id="1050" parentID="1048" level="2" writerID="0" creatorID="0" nodeType="1046" template="1044" sortOrder="1" createDate="2008-06-01T23:14:52" updateDate="2014-11-28T22:59:50" nodeName="Go further" urlName="go-further" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048,1050" isDoc=""><bodyText><![CDATA[
<p>The Simple Starter Kit only scratches the surface of what''s
possible with Umbraco. Below the Simple Starter Kit and its modules
lies a great architecture that lets you implement whatever you
need.</p>

<p>With Umbraco you''ve finally got a solid, open and reliable
platform for websites as basic as the Simple site, and Umbraco can
be rapidly expanded to support multi-language websites,
collaboration platforms and intra/extranets, to name just a
few.</p>

<p>Advanced functionality is created with Umbraco macros, built
with XSLT and Umbraco''s award-winning .NET integration, including
full support for any .NET User or Custom control. Create and
integrate your own .NET macros in mere minutes with point and click
simplicity. Simply copy your controls to the Umbraco website, go to
the <strong>Developer</strong> section and create a new macro,
selecting your control from the list.</p>

<p>You can also use <a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started/working-with-webmatrix"
 title="Working with Razor">Microsoft''s Razor</a> syntax to quickly
add dynamic functionality to your site.</p>

<p>We''ve also gathered the best community macros into a repository
that''s also accessed from the <strong>Developer</strong> section,
in the <strong>Packages</strong> area. You can find more
information <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/what-are-macros"
 title="About creating Umbraco macros">about creating macros</a>,
on the Umbraco website.</p>

<p>The sky is the limit with Umbraco, and you have the benefit a
friendly community, training, and guaranteed support. Find out how
to <a href="http://umbraco.org/help-and-support"
title="Get Umbraco Support">get help</a>.</p>
]]></bodyText><umbracoNaviHide>0</umbracoNaviHide></umbTextpage>');
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (1051,'<umbTextpage id="1051" parentID="1048" level="2" writerID="0" creatorID="0" nodeType="1046" template="1044" sortOrder="2" createDate="2008-06-01T23:11:56" updateDate="2014-11-28T22:59:50" nodeName="Getting started" urlName="getting-started" writerName="umbraco.4.11.9" creatorName="umbraco.4.11.9" path="-1,1048,1051" isDoc=""><bodyText><![CDATA[
<p>You''ve installed Umbraco and the basic Simple website.</p>

<p>Edit the text on the homepage and create a site structure by
adding new texpages to your site. This is all done in the
<strong>Content</strong> section.</p>

<p>If you find the editing options provided by the Simple site too
limited for you needs, simply add more properties to the page by
going to the <strong>Settings</strong> section, expanding the
<strong>Document Types</strong> item and adding new properties on
the <strong>Generic Properties</strong> tab. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/document-types"
 title="About Umbraco Document Types">document types and
properties</a> at the <a href="http://umbraco.org"
title="The Umbraco Website">Umbraco website</a>.</p>

<p>You''ll probably want to personalize your site by changing the
current design. This is also done in the <strong>Settings</strong>
section, either by editing the CSS styles and HTML templates or by
selecting and applying a Skin. Umbraco uses master templates, so
the main, common markup is placed in the <strong>Starterkit
Master</strong> template, while the Homeage and Textpage have
separate templates for their unique layouts. You can find more
information about <a
href="http://umbraco.org/help-and-support/video-tutorials/introduction-to-umbraco/sitebuilder-introduction/templates"
 title="Umbraco Templates and Stylesheets">templates and css</a> in
umbraco at the umbraco website.</p>

<p>Once you''re happy with your site''s design, you might want to add
more functionality, such as automated navigation. This is done by
<a
href="http://umbraco.org/help-and-support/video-tutorials/getting-started"
 title="Umbraco Modules">installing Umbraco modules</a>.</p>
]]></bodyText><umbracoNaviHide>0</umbracoNaviHide></umbTextpage>');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (1,1048,'2b7d45e1-ffce-4082-a9cf-a769d9ffd130','2014-11-28 22:59:49.757');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (2,1049,'7f42a15e-8125-492b-b092-35b6ccef1e2d','2014-11-28 22:59:49.983');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (3,1050,'6bdbf441-dc94-4154-977b-dd6cd4ecad01','2014-11-28 22:59:50.043');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (4,1051,'2544835f-bd40-4693-9afd-3f1d9558d292','2014-11-28 22:59:50.107');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (5,1048,'c8438d5b-ec6d-4f1f-9621-d531ed9962fe','2014-11-28 22:59:50.190');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (6,1049,'bc7bbbef-94a3-472c-91c5-fad8c153657a','2014-11-28 22:59:50.273');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (7,1050,'1bf77d6e-23da-479f-b180-4fdc0a2bafac','2014-11-28 22:59:50.327');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (8,1051,'6d9189da-4d1f-4e60-9380-f9956de3cdec','2014-11-28 22:59:50.373');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (9,1048,'08cebd7a-79de-4fbd-91cc-851a22a8f9ed','2014-11-28 23:03:06.810');
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (10,1048,'a6a8297f-5935-4f0e-9874-948fcf79b83b','2014-11-28 23:03:06.863');
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId]) VALUES (1031,1031);
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId]) VALUES (1031,1032);
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId]) VALUES (1031,1033);
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId]) VALUES (1045,1046);
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId]) VALUES (1046,1046);
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[masterContentType]) VALUES (532,1031,'Folder','folder.gif','folder.png',NULL,0);
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[masterContentType]) VALUES (533,1032,'Image','mediaPhoto.gif','mediaPhoto.png',NULL,0);
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[masterContentType]) VALUES (534,1033,'File','mediaFile.gif','mediaFile.png',NULL,0);
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[masterContentType]) VALUES (535,1045,'umbHomepage','.sprTreeFolder','folder.png','The homepage of a starter kit website.',0);
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[masterContentType]) VALUES (536,1046,'umbTextpage','.sprTreeDoc','doc.png','This is the standard content page for a starter kit website.',0);
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (1,1048,1045);
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (2,1049,1046);
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (3,1050,1046);
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (4,1051,1046);
CREATE INDEX [IX_cmsPropertyData_cmsPropertyData] ON [cmsPropertyData] ([id] ASC);