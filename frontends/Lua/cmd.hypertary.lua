#!/usr/bin/env lua
-- Hypertary à la
--       ...                                                                  ..
--   .zf"` `"tu                               .8u                 .uef^"     888B.
--  x88      '8N.    x.    .                 m888R-             :d88E       48888E
--  888k     d88&  .@88k  z88u         u      98P         u     `888E       '8888'
--  8888N.  @888F ~"8888 ^8888      us888u.   ^8       us888u.   888E .z8k   Y88F
--  `88888 9888%    8888  888R   .@88 "8888"  J"    .@88 "8888"  888E~?888L  '88
--    %888 "88F     8888  888R   9888  9888  +"     9888  9888   888E  888E   8F
--     8"   "*h=~   8888  888R   9888  9888         9888  9888   888E  888E   4
--   z8Weu          8888 ,888B . 9888  9888         9888  9888   888E  888E   .
--  ""88888i.   Z  "8888Y 8888"  9888  9888         9888  9888   888E  888E  u8N.
-- "   "8888888*    `Y"   'YP    "888*""888"        "888*""888" m888N= 888> "*88%
--       ^"**""                   ^Y"   ^Y'          ^Y"   ^Y'   `Y"   888    ""
--                                                                    J88"
--                                                                    @%
--                                                                  :"
-- Requires:
-- 	dkjson
-- 	ltn12
-- 	socket.http

---------------------
-- Print Variables --
---------------------
--[[ function deprint, usage: visually debug string (f) and value (v) ]]--
function deprint(f,v)
	if not f then print(' -> ')
	elseif (v and type(v) == 'string') then print(f .. ' -> ' .. v)
	elseif (v and type(v) == 'table') then
		print(f .. ' -> table \n{')
		for k,v in pairs(v) do
			print('',k,v)
		end; print('}')
	else print(f .. ' ->  ')
	end
end

function line() print('--------------------------------------------\n') end

-------------------
-- List Services --
-------------------
function hype_list()

	local method = "GET"
	local url = "http://localhost:8080/services"
	local reqbody = { "this is the body to be sent via post" }
	local lesock = httpsock(method, url, reqbody)

	return(lesock)
end


------------------------
-- Adding New Service --
------------------------
function hype_add_form_submit(table)

	-- Simply pass in a table:
	-- table.example = {
	-- 	url = "http://[fcbf:7bbc:32e4:716:bd00:e936:c927:fc14]",
	-- 	name = "Socialnode",
	-- 	description = "A microblogging social network"
	-- }

	-- Later, pass in table.method or table.url
	local method = "POST"
	local url = "http://localhost:8080/services/new"

	local lesock = httpsock(method, url, table)

	return(lesock)

end

-------------------
-- POST/GET HTTP --
-------------------
function httpsock(method, url, reqbody) -- Diego Nehab

	local http = require("socket.http")
	local ltn12 = require("ltn12")
	local json = require("dkjson")

	-- Request
	if type(reqbody) == 'table' then
		reqbody = json.encode(reqbody)
	elseif type(reqbody) == 'string' then
		reqbody = json.encode(reqbody)
	end

	-- Response
	local respbody = {} -- for the response body

	-- Extra
	if 'debug' == 'on' then
		deprint('result',result)
		deprint('respcode',respcode)
		deprint('respheaders',respheaders)
		deprint('respstatus',respstatus)
		deprint('respbody',respbody)
		deprint('reqbody',reqbody)
		deprint('contentLen',#reqbody)
		deprint('reqbodyJson', reqbody)
	end
	-- Start HTTP socket to post/get reqbody
	local result, respcode, respheaders, respstatus = http.request {
		method = method,
		url = url,
		source = ltn12.source.string(reqbody),
		headers = {
		    ["content-type"] = "text/plain",
		    ["content-length"] = tostring(#reqbody)
		},
		sink = ltn12.sink.table(respbody)
	}
	-- get body as string by concatenating table filled by sink
	respbody = table.concat(respbody)
	return(respbody)
end

--------------
-- Examples --
--------------

--[[ Print the returned output from hype_list() ]]--
deprint('hypertary list',hype_list())
-----------------------------------------------------------------


--[[  Example of json.decode(hype_list()): ]] --
-- http://[fc1a:8bc5:4fa2:7dd1:2a6d:5aa8:7639:eb7c]
	-- EZCrypt	(Encrypted Pastebin)
local hl=hype_list()
local json=require("dkjson")

for k,v in pairs(json.decode(hl)) do
	print (k .. '\n',v['name'],'('..v['description']..')')
end
-----------------------------------------------------------------


--[[ Examples for Meshbox on OpenWrt ]]--

-- Next:
--  Pass JSON to cmd.hypertary.lua via ubus
--  with uci, cjdns_admin, or other field and variables

-----------------------------------------------------------------


--[[ Example for site cataloging ]]--

error("Cataloging Example from: https://wiki.projectmeshnet.org/User:Shnatsel/Known_Hyperboria_Sites_WIP")

local table = {}
table.reqbody = { url = "http://[fcbf:7bbc:32e4:716:bd00:e936:c927:fc14]", name = "socialnode", description = "A microblogging social network" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc13:6176:aaca:8c7f:9f55:924f:26b3:4b14]", name = "Diaspora", description = "A social networking site " }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc3a:956e:4b69:1c1e:5ebc:11a5:3e71:3e7e]", name = "Uppit: The front page of hyperboria", description = "Reddit clone" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc97:d627:b1b6:3021:7b55:1ea3:1b3b:75a5]", name = "HypeDiscuss", description = "Hypeboria Forum, All topics." }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcec:ae97:8902:d810:6c92:ec67:efb2:3ec5]", name = "urlcloud", description = "A simple file sharing site for hyperboria" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcf4:e309:14b5:5498:cafd:4f59:4b9c:7f84]:6969/announce", name = "CJDNET OpenTracker", description = "BitTorrent Tracker" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc1e:af9f:b436:7aa0:5bce:dfc:cba:c713]:6969/announce", name = "thefinn93.hype", description = "BitTorrent Tracker" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "adc://[fca1:ca48:d106:db25:fc47:2cc9:16ff:92f5]:1511", name = "Hyper Hub", description = "Public ADC filesharing hub" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcbf:7bbc:32e4:716:bd00:e936:c927:fc14]", name = "HypeIRC", description = "Hyperboria-only IRC Network" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcec:0cbd:3c03:1a2a:063f:c917:b1db:1695]", name = "napier", description = "IRC server" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc87:5019:8605:51f6:9ed:14d1:19b8:5c6]", name = "rows.io", description = "A public Jabber/XMPP server on both hyperboria and the internet. in-band registration." }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcd6:b2a5:e3cc:d78d:fc69:a90f:4bf7:4a02]", name = "Jabber/XMPP", description = "Inband registration, voice/video chat, etc" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc73:8c84:69b3:49a7:627:a4f2:fdc7:4ab]", name = "Jabber/XMPP", description = "Inband registration, voice/video chat, etc" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcb5:e03e:f737:6a60:e23d:f8f8:27af:41ee]", name = "Mumble", description = "Group voice chat." }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc20:b48d:4ff4:275a:a86f:48d9:2cff:c]", name = "HypeSearch", description = "A search engine for Hyperboria" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc47:1d4e:cf5c:ae0b:6f00:76bd:5f36:a23c]", name = "What.k", description = "Hyperboria web search (in development)" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcfb:69f9:ad61:5ad0:6b59:a442:84a0:93e0]/git", name = "Hyperboria git mirrors", description = "A mirror of any projects Jercos thinks are important" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcb5:e03e:f737:6a60:e23d:f8f8:27af:41ee]", name = "Arch Linux Repository Mirror", description = "A Mirror of the Arch Linux Repository" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc59:36a2:27a9:ccf3:1903:9fc6:5a8f:7499]", name = "Gitboria", description = "GitHub clone" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc93:e5b5:7cde:7983:f50c:fe31:106b:1f88]/gitweb", name = "NeoRetro", description = "git with gitweb" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcb5:e03e:f737:6a60:e23d:f8f8:27af:41ee]", name = "Minecraft", description = "Punch trees" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc51:57de:bdef:e439:ada3:55b6:4347:36f1]", name = "Minecraft", description = "For all your Minecrafting needs" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcbf:efd5:d2e4:a4f5:32ed:4aca:f3d9:b80b]", name = "hPing", description = "A web-ping application to see if it is up for others" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc5d:baa5:61fc:6ffd:9554:67f0:e290:7535]", name = "NodeInfo", description = "Also HypeDNS server" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcfd:9511:69cc:a05e:4eb2:ed20:c6a0:52e3]", name = "hyperboria.name", description = "Hyperboria-only e-mail service and subdomain registration" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc93:e5b5:7cde:7983:f50c:fe31:106b:1f88]/wiki", name = "NeoRetro", description = "Cjdns-wiki" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc40:21da:e099:3a0b:6eee:82bb:b6cc:ffff]", name = "Grey's Node", description = "Public peer, downstream caching HypeDNS server" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc96:5f84:bf96:8814:455d:37c2:ffcd:e563]", name = "Your voice on Hyperboria", description = "WordPress blog hosting" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc96:5f84:bf96:8814:455d:37c2:ffcd:e563]", name = "Etherpad Lite", description = "Collaborative realtime planning notepad" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcd5:7d07:2146:f18f:f937:d46e:77c9:80e7]/mediagoblin/", name = "MediaGoblin instance", description = "Also available on clearnet" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "nntp://[fc01:1c4a:a0a0:ada4:5ec5:6c4a:5d2:ad4]", name = "funkspiel", description = "Usenet server (text only)" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc1e:af9f:b436:7aa0:5bce:dfc:cba:c713]:11371", name = "thefinn93.hype", description = "OpenPGP keyserver" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcf6:ab1c:1ff3:3089:3c62:2270:6093:ba7c]", name = "OpenNIC DNS slave server", description = "First OpenNIC DNS slave on hyperboria, Domain registrar http://opennicproject.org" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc90:8f10:9ca3:12a1:ab12:c98d:680:d915]", name = "Public BBS", description = "SynchroNet BBS (SSH via port 23, user and pass: bbs)" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc38:4c2c:1a8f:3981:f2e7:c2b9:6870:6e84]/cjdns.html", name = "ircerr's page", description = "lots of great resources" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fce5:de17:cbde:c87b:5289:556:8b83:c9c8]", name = "Cjd's page", description = "Contains javascript microserver code" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc1a:8bc5:4fa2:7dd1:2a6d:5aa8:7639:eb7c]", name = "EZCrypt", description = "Encrypted Pastebin" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fce1:ab7a:577c:12b6:35a3:be68:6fde:ea85]", name = "URL.s/URLw.us", description = "url shortener for urls inside and outside the darknet" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fccb:c308:4b13:fc55:00cd:1dba:963e:d3b5]", name = "Netherlands Hyperboria Exchange", description = "Hyperboria exchange in NL" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fcf1:4c00:7171:d61a:d4ce:3a5d:ea79:ad3e]", name = "JPH on Mesh", description = "RIP JPH" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fce3:14aa:64d0:f72a:cb3f:6c04:3943:ffb6]", name = "neko259@Hype", description = "OwnCloud, wiki, redmine, imageboard (neboard)" }
hype_add_form_submit(table.reqbody)

table.reqbody = { url = "http://[fc7b:ce4a:f655:f634:792b:5924:29c4:60fa]", name = "hyperlib", description = "The Library of Hyperboria" }
hype_add_form_submit(table.reqbody)
