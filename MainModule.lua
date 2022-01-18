--[[

	Trello API Module in lua, made by minhaz1234567
	Link to Trello API: https://developer.atlassian.com/cloud/trello/rest/api-group-actions/
	The parameters in the functions are in the order listed on the docs.
	This is not finished yet, report bugs if you find any.
	Made for upBase LLC.
	
]]

local module = {}
local HttpService = game:GetService("HttpService")

module.key = 'YOURKEYGOESHERE'

module.token = "YOURTOKENGOESHERE"

module.endpoint = "https://api.trello.com/1"

module.GetBoardMemberships = function(id,filter,activity,orgMemberType,member,member_fields)
	filter = filter or "all"
	activity = tostring(activity) or "false"
	orgMemberType = tostring(orgMemberType) or "false"
	member = tostring(member) or "false"
	member_fields = member_fields or "id,avatarHash,avatarUrl,initials,fullName,username,confirmed,memberType"
	if id == nil then
		return warn("Unable to get board memberships: Board ID is nil or is not provided.")
	end
	local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."/memberships?filter="..filter.."&activity="..activity.."&orgMemberType="..orgMemberType.."&member="..member.."&member_fields="..member_fields.."&key="..module.key.."&token="..module.token)
	return HttpService:JSONDecode(response)	
end

module.GetBoard = function(id,actions,boardStars,cards,card_pluginData,checklists,customFields,fields,labels,lists,members,memberships,pluginData,organization,organization_pluginData,myPrefs,tags)
	actions = actions or "all"
	boardStars = boardStars or "none"
	cards = cards or "none"
	card_pluginData = tostring(card_pluginData) or "false"
	checklists = checklists or "none"
	customFields = tostring(customFields) or "false"
	fields = fields or "closed,dateLastActivity,dateLastView,desc,descData,idMemberCreator,idOrganization,invitations,invited,labelNames,memberships,name,pinned,powerUps,prefs,shortLink,shortUrl,starred,subscribed,url"
	labels = labels or "none"
	lists = lists or "open"
	members = members or "none"
	memberships = memberships or "none"
	pluginData = tostring(pluginData) or "false"
	organization = tostring(organization) or "false"
	organization_pluginData = tostring(organization_pluginData) or "false"
	myPrefs = tostring(myPrefs) or "false"
	tags = tostring(tags) or "false"
	if id == nil then
		return warn("Unable to get board: Board ID is nil or is not provided.")
	end
	local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."?actions="..actions.."&boardStars="..boardStars.."&cards="..cards.."&cards_pluginData="..cards_pluginData.."&checklists="..checklists.."&customFields="..customFields.."&fields="..fields.."&labels="..labels.."&lists="..lists.."&members="..members.."&memberships="..memberships.."&pluginData="..pluginData.."&organization="..organization.."&organization_pluginData="..organization_pluginData.."&myPrefs="..myPrefs.."&tags="..tags.."&key="..module.key.."&token="..module.token)
	return HttpService:JSONDecode(response)
	
end

module.UpdateBoard = function(id,name,desc,closed,subscribed,idOrganization,permissionLevel,selfJoin,cardCovers,hideVotes,invitations,voting,comments,background,cardAging,calendarFeedEnabled,labelNames_green,labelNames_yellow,labelNames_orange,labelNames_red,labelNames_purple,labelNames_blue)
	if id == nil then
		return warn("Unable to update board: Board ID is nil or is not provided.")
	end
	local Board = module.GetBoard(id)
	name = name or Board.name
	desc = desc or Board.desc
	closed = tostring(closed) or Board.closed
	subscribed = subscribed or Board.subscribed
	idOrganization = idOrganization or Board.idOrganization
	permissionLevel = permissionLevel or Board.prefs.permissionLevel
	selfJoin = selfJoin or Board.prefs.selfJoin
	cardCovers = cardCovers or Board.prefs.selfJoin
	hideVotes = hideVotes or Board.prefs.hideVotes
	invitations = invitations or Board.prefs.invitations
	voting = voting or Board.prefs.voting
	comments = comments or Board.prefs.comments
	background = background or Board.prefs.background
	cardAging = cardAging or Board.prefs.cardAging
	calendarFeedEnabled = calendarFeedEnabled or Board.prefs.calendarFeedEnabled
	labelNames_green = labelNames_green or Board.labelNames.green
	labelNames_yellow = labelNames_yellow or Board.labelNames.yellow
	labelNames_red = labelNames_red or Board.labelNames.red
	labelNames_purple = labelNames_purple or Board.labelNames.purple
	labelNames_blue = labelNames_blue or Board.labelNames.blue
		local requestMethod = "PUT"
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."?name="..name.."&desc="..desc.."&closed="..closed.."&subscribed="..subscribed.."&idOrganization="..idOrganization.."&prefs/permissionLevel="..permissionLevel.."&prefs/selfJoin="..selfJoin.."&prefs/cardCovers="..cardCovers.."&prefs/hideVotes="..hideVotes.."&prefs/invitations="..invitations.."&prefs/voting="..voting.."&prefs/comments="..comments.."&prefs/background="..background.."&prefs/cardAging="..cardAging.."&prefs/calendarFeedEnabled="..calendarFeedEnabled.."&labelNames/green="..labelNames_green.."&labelNames/yellow="..labelNames_yellow.."&labelNames/orange="..labelNames_orange.."&labelNames/red=" ..labelNames_red.."&labelNames/purple="..labelNames_purple.."&labelNames/blue="..labelNames_blue.."&key="..module.key.."&token="..module.token,
			Method = requestMethod
		})
		return HttpService:JSONDecode(response)
end

module.DeleteBoard = function(id)
	if id == nil then
		return warn("Unable to update board: Board ID is nil or is not provided.")
	end
	local requestMethod = "DELETE"
	local response = HttpService:RequestAsync({
		Url = module.endpoint.."/boards/"..id.."?key="..module.key.."&token="..module.token,
		Method = requestMethod
	})
	return HttpService:JSONDecode(response)
	
end

module.GetBoardField = function(id,field)
	if id == nil then
		return warn("Unable to get board field: Board ID is nil or is not provided.")
	end
	if field == nil then
		return warn("Unable to get board field: Field is nil or is not provided.")
	end
	local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."/"..field.."?key="..module.key.."&token="..module.token)
	return HttpService:JSONDecode(response) 
end

module.GetBoardActions = function(id,filter)
	if id == nil then
		return warn("Unable to get board actions: Board ID is nil or is not provided.")
	end
	local success,err = pcall(function()
		if filter == nil then
			local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."/actions".."?key="..module.key.."&token="..module.token)
			return HttpService:JSONDecode(response)
		else
			local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."/actions?filter="..filter.."&key="..module.key.."&token="..module.token)
			return HttpService:JSONDecode(response)
		end		
	end)
	if err then
		return warn("Unexpected error whilst getting board field: "..err)
	end
end

module.GetCard = function(id,idCard)
	if id == nil then
		return warn("Unable to get card: Board ID(1st param) is nil or is not provided.")
	end
	if idCard == nil then
		return warn("Unable to get card: Card ID(2nd param) is nil or is not provided.")
	end
		local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."/cards/"..idCard.."?key="..module.key.."&token="..module.token)
		return HttpService:JSONDecode(response)
	
end

module.GetBoardStars = function(boardId,filter)
	if boardId == nil then
		return warn("Unable to get Board Stars: Board ID(1st param) is nil or is not provided.")
	end
	filter = filter or "mine"
		local response = HttpService:GetAsync(module.endpoint.."/boards/"..boardId.."/boardStars?filter="..filter.."&key="..module.key.."&token="..module.token)
		return HttpService:JSONDecode(response)
end

module.GetBoardChecklists = function(id)
	if id == nil then
		return warn("Unable to get checklists: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:GetAsync(module.endpoint.."/boards/"..id.."/checklists".."?key="..module.key.."&token="..module.token)
		return HttpService:JSONDecode(response)
end

module.CreateChecklist = function(id,name)
	if id == nil then
		return warn("Unable to create checklist: Board ID(1st param) is nil or is not provided.")
	end
	if name == nil then
		return warn("Unable to create checklist: Card ID(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/checklists?name="..name.."&key="..module.key.."&token="..module.token,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.GetBoardCards = function(id)
	if id == nil then
		return warn("Unable to get cards: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/cards?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
	
end

module.GetFilteredCards = function(id,filter)
	if id == nil then
		return warn("Unable to get cards: Board ID(1st param) is nil or is not provided.")
	end
	if filter == nil then
		return warn("Unable to get cards: Filter(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/cards/"..filter.."?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.GetBoardCustomFields = function(id)
	if id == nil then
		return warn("Unable to get Custom Fields: Board ID(1st param) is nil or is not provided.")
	end

		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/customFields?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.GetBoardLabels = function(id,fields,limit)
	if id == nil then
		return warn("Unable to get Labels: Board ID(1st param) is nil or is not provided.")
	end
	fields = fields or "all"
	limit = tostring(limit) or "50"
	if tonumber(limit) < 0 or tonumber(limit) > 1000 then
		return warn("Unexpected error whilst getting labels: Limit must be in the range of 0 and 100")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/labels?key="..module.key.."&token="..module.token.."&fields="..fields.."&limit="..limit,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.CreateLabel = function(id,name,color)
	if id == nil then
		return warn("Unable to create label: Board ID(1st param) is nil or is not provided.")
	end
	if name == nil then
		return warn("Unable to create label: Name(2nd param) is nil or is not provided.")
	end
	color = color or ""
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/labels".."?key="..module.key.."&token="..module.token.."&name="..name.."&color="..color,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.GetBoardLists = function(id,cards,card_fields,filter,fields)
	if id == nil then
		return warn("Unable to get lists: Board ID(1st param) is nil or is not provided.")
	end

	cards = cards or "all"
	card_fields = card_fields or "all"
	filter = filter or "all"
	fields = fields or "all"

		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/lists".."?key="..module.key.."&token="..module.token.."&cards="..cards.."&card_fields="..card_fields.."&filter="..filter.."&fields="..fields,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)

end

module.CreateBoardList = function(id,name,pos)
	if id == nil then
		return warn("Unable to create lists: Board ID(1st param) is nil or is not provided.")
	end
	if name == nil then
		return warn("Unable to create lists: Name(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/lists".."?key="..module.key.."&token="..module.token.."&name="..name.."&pos="..pos,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.GetFilteredLists = function(id,filter)
	if id == nil then
		return warn("Unable to get lists: Board ID(1st param) is nil or is not provided.")
	end
	if filter == nil then
		return warn("Unable to get lists: Filter(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/lists/"..filter.."?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.GetBoardMembers = function(id)
	if id == nil then
		return warn("Unable to get members: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/members?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.InviteMemberToBoardViaEmail = function(id,email,Type,fullName)
	if id == nil then
		return warn("Unable to invite member: Board ID(1st param) is nil or is not provided.")
	end
	if email == nil then
		return warn("Unable to invite member: Email(1st param) is nil or is not provided.")
	end
	Type = Type or "normal"
	if fullName == nil then
			local response = HttpService:RequestAsync({
				Url = module.endpoint.."/boards/"..id.."/members?key="..module.key.."&token="..module.token.."&email="..email.."&type="..Type,
				Method = "PUT"
			})
			return HttpService:JSONDecode(response)
	else
			local response = HttpService:RequestAsync({
				Url = module.endpoint.."/boards/"..id.."/members?key="..module.key.."&token="..module.token.."&email="..email.."&type="..Type,
				Method = "PUT",
				Body = HttpService:JSONEncode({
					fullName = fullName
				})
			})
			return HttpService:JSONDecode(response)
	end
end

module.AddMemberToBoard = function(id,idMember,Type,allowBillableGuest)
	if id == nil then
		return warn("Unable to add member: Board ID(1st param) is nil or is not provided.")
	end
	if idMember == nil then
		return warn("Unable to add member: Member ID(2nd param) is nil or is not provided.")
	end
	if Type == nil then
		return warn("Unable to add member: Type(3rd param) is nil or is not provided.")
	end
	allowBillableGuest = allowBillableGuest or "false"
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/members/"..idMember.."?key="..module.key.."&token="..module.token.."&type="..Type.."&allowBillableGuest="..allowBillableGuest,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.RemoveBoardMember = function(id,idMember)
	if id == nil then
		return warn("Unable to delete member: Board ID(1st param) is nil or is not provided.")
	end
	if idMember == nil then
		return warn("Unable to delete member: Member ID(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/members/"..idMember.."?key="..module.key.."&token="..module.token,
			Method = "DELETE"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateBoardMembersMembership = function(id,idMembership,Type,member_fields)
	if id == nil then
		return warn("Unable to Update Membership: Board ID(1st param) is nil or is not provided.")
	end
	if idMembership == nil then
		return warn("Unable to Update Membership: Member ID(2nd param) is nil or is not provided.")
	end
	if Type == nil then
		return warn("Unable to Update Membership:  Type(3rd param) is nil or is not provided.")
	end
	member_fields = member_fields or "fullName,username"
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/memberships/"..idMembership.."?key="..module.key.."&token="..module.token.."&type="..Type,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateEmailPositionPref = function(id,value)
	if id == nil then
		return warn("Unable to Update Email Position Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update Email Position Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/emailPosition".."?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateIdEmailListPref = function(id,value)
	if id == nil then
		return warn("Unable to Update ID Email List Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update ID Email List Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/idEmailList".."?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateShowListGuidePref = function(id,value)
	if id == nil then
		return warn("Unable to Update Show List Guide Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update Show List Guide Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/showListGuide?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateShowSidebarPref = function(id,value)
	if id == nil then
		return warn("Unable to Update Show Sidebar Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update Show Sidebar Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/showSidebar?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateShowSidebarActivityPref = function(id,value)
	if id == nil then
		return warn("Unable to Update Show Sidebar Activity Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update Show Sidebar Activity Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/showSidebarActivity?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateShowSidebarBoardActionsPref = function(id,value)
	if id == nil then
		return warn("Unable to Update Show Sidebar Board Actions Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update Show Sidebar Board Actions Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/showSidebarBoardActions?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateShowSidebarMembersPref = function(id,value)
	if id == nil then
		return warn("Unable to Update Show Sidebar Members Pref: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to Update Show Sidebar Members Pref: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/myPrefs/showSidebarMembers?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.CreateBoard = function(name,defaultLabels,defaultLists,desc,idOrganization,idBoardSource,keepFromSource,powerUps,prefs_permissionLevel,prefs_voting,prefs_comments,prefs_invitations,prefs_selfJoin,prefs_cardCovers,prefs_background,prefs_cardAging)
	if name == nil then
		return warn("Unable to Create Board: Board Name(1st param) is nil or is not provided.")
	end
	defaultLabels = tostring(defaultLabels) or "false"
	defaultLists = tostring(defaultLists) or "true"
	desc = desc or ""
	idOrganization = idOrganization or ""
	idBoardSource = idBoardSource or ""
	keepFromSource = keepFromSource or "none"
	powerUps = powerUps or ""
	prefs_permissionLevel = prefs_permissionLevel or "private"
	prefs_voting = prefs_voting or "disabled"
	prefs_comments = prefs_comments or "members"
	prefs_invitations = prefs_invitations or "members"
	prefs_selfJoin = prefs_selfJoin or "true"
	prefs_cardCovers = prefs_cardCovers or "true"
	prefs_background = prefs_background or "blue"
	prefs_cardAging = prefs_cardAging or "regular"
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards?key="..module.key.."&token="..module.token.."&name="..name.."&defaultLabels="..defaultLabels.."&defaultLists="..defaultLists.."&desc="..desc.."&idOrganization="..idOrganization.."&idBoardSource="..idBoardSource.."&keepFromSource="..keepFromSource.."&powerUps="..powerUps.."&prefs_permissionLevel="..prefs_permissionLevel.."&prefs_voting="..prefs_voting.."&prefs_comments="..prefs_comments.."prefs_invitations="..prefs_invitations.."&prefs_selfJoin="..prefs_selfJoin.."&prefs_cardCovers="..prefs_cardCovers.."&prefs_background="..prefs_background.."&prefs_cardAging="..prefs_cardAging,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.CreateCalendarKey = function(id)
	if id == nil then
		return warn("Unable to create calendar key: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/calendarKey/generate?key="..module.key.."&token="..module.token,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.CreateEmailKey = function(id)
	if id == nil then
		return warn("Unable to create emailKey: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/emailKey/generate?key="..module.key.."&token="..module.token,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.CreateTag = function(id,value)
	if id == nil then
		return warn("Unable to create tag: Board ID(1st param) is nil or is not provided.")
	end
	if value == nil then
		return warn("Unable to create tag: Value(2nd param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/idTags?key="..module.key.."&token="..module.token.."&value="..value,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.MarkBoardViewed = function(id)
	if id == nil then
		return warn("Unable to mark board viewed: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/markedAsViewed?key="..module.key.."&token="..module.token,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.GetEnabledPowerUps = function(id)
	if id == nil then
		return warn("Unable to get enabled power-ups: Board ID(1st param) is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/boardPlugins?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.GetPowerUps = function(id,filter)
	if id == nil then
		return warn("Unable to get power-ups: Board ID(1st param) is nil or is not provided.")
	end
	filter = filter or "enabled"
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/boards/"..id.."/plugins?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.CreateCard = function(name,idList,desc,pos,due,dueComplete,idMembers,idLabels,urlSource,fileSource,mimeType,idCardSource,keepFromSource,address,locationName,coordinates)

	if idList == nil then
		return warn("Unable to create card: list id(1st param) is nil or is not provided.")
	end
	name = name or ""
	desc = desc or ""
	pos = pos or "top"
	due = due or ""
	dueComplete = dueComplete or ""
	idMembers = idMembers or ""
	urlSource = urlSource or ""
	fileSource = fileSource or ""
	mimeType = mimeType or ""
	idCardSource = idCardSource or ""
	keepFromSource = keepFromSource or "all"
	address = address or ""
	locationName = locationName or ""
	coordinates = coordinates or ""
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/cards?key="..module.key.."&token="..module.token.."&name="..name.."&desc="..desc.."&pos="..pos.."&due="..due.."&dueComplete="..dueComplete.."&idMembers="..idMembers.."&urlSource="..urlSource.."&fileSource="..fileSource.."&mimeType="..mimeType.."&idCardSource="..idCardSource.."&keepFromSource="..keepFromSource.."&address="..address.."&locationName="..locationName.."&coordinates="..coordinates,
			Method = "POST"
		})
		return HttpService:JSONDecode(response)
end

module.GetCard = function(id,fields,actions,attachments,attachments_fields,members,member_fields,membersVoted,memberVoted_fields,checkItemStates,checklists,checklist_fields,board,board_fields,list,pluginData,stickers,sticker_fields,customFieldItems)
	if id == nil then
		return warn("Unable to get card: Card ID(1st param) is nil or is not provided.")
	end
	fields = fields or "all"
	actions = actions or ""
	attachments = attachments or "false"
	attachments_fields = attachments_fields or "all"
	members = members or "false"
	member_fields = member_fields or "all"
	membersVoted = membersVoted or "false"
	memberVoted_fields = memberVoted_fields or "all"
	checkItemStates = checkItemStates or "false"
	checklists = checklists or "none"
	checklist_fields = checklist_fields or "all"
	board = board or "false"
	board_fields = board_fields or "all"
	list = list or "false"
	pluginData = pluginData or "false"
	stickers = stickers or "false"
	sticker_fields = sticker_fields or "all"
	customFieldItems = customFieldItems or "false"
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/cards/"..id.."?key="..module.key.."&token="..module.token.."&id="..id.."&fields="..fields.."&actions="..actions.."&attachments="..attachments.."&attachment_fields="..attachment_fields.."&members="..members.."&member_fields="..member_fields.."&membersVoted="..membersVoted.."&memberVoted_fields="..memberVoted_fields.."&checkItemStates="..checkItemStates.."&checklists="..checklists.."&checklist_fields="..checklist_fields.."&board="..board.."&board_fields="..board_fields.."&list="..list.."&pluginData="..pluginData.."&stickers="..stickers.."&sticker_fields="..sticker_fields.."&customFieldItems="..customFieldItems,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

module.UpdateCard = function(id,name,desc,closed,idMembers,idAttachmentCover,idList,idLabels,idBoard,pos,due,dueComplete,subscribed,address,locationName,coordinates,cover)
	if id == nil then
		return warn("Unable to update card: Card ID is nil or is not provided.")
	end
	local Card = module.GetCard(id)
	name = name or Card.name
	desc = desc or Card.desc
	closed = closed or Card.closed
	idMembers = idMembers or Card.idMembers
	idAttachmentCover = idAttachmentCover or Card.idAttachmentCover
	idList = idList or Card.idList
	idLabels = idLabels or Card.idLabe
	idBoard = idBoard or Card.idBoard
	pos = pos or Card.pos
	due = due or Card.due
	dueComplete = dueComplete or Card.dueComplete
	subscribed = subscribed or Card.subscribed
	address = address or Card.address
	locationName = locationName or Card.locationName
	coordinates = coordinates or Card.coordinates
	cover = cover or Card.cover
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/cards/"..id.."?key="..module.key.."&token="..module.token.."&id="..id.."&name="..name.."&desc="..desc.."&closed="..closed.."&idMembers="..idMembers.."&idAttachmentCover="..idAttachmentCover.."&idList="..idList.."&idLabels="..idLabels.."&idBoard="..idBoard.."&pos="..pos.."&due="..due.."&dueComplete="..dueComplete.."&subscribed="..subscribed.."&address="..address.."&locationName="..locationName.."&coordinates="..coordinates.."&cover="..HttpService:JSONEncode(cover),
			Method = "PUT"
		})
		return HttpService:JSONDecode(response)
end

module.DeleteCard = function(id)
	if id == nil then
		return warn("Unable to delete card: Card ID is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/cards/"..id.."?key="..module.key.."&token="..module.token,
			Method = "DELETE"
		})
		return HttpService:JSONDecode(response)
end

--LISTS

module.GetListCards = function(id)
	if id == nil then
		return warn("Unable to get list card: List ID is nil or is not provided.")
	end
		local response = HttpService:RequestAsync({
			Url = module.endpoint.."/lists/"..id.."/cards?key="..module.key.."&token="..module.token,
			Method = "GET"
		})
		return HttpService:JSONDecode(response)
end

return module
