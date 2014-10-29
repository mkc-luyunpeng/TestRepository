Set = {}
mt = {} --元表
 
function Set.new(l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do
        set[v] = true
    end
    return set
end


--================================================
function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e;
    end
    return "{" .. table.concat(l, ",") .. "}"
end
 
 
function Set.print(s)
    print(Set.tostring(s))
end

--1 加(__add), 并集===============================
function Set.union(a, b)
--[[    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
        error("attemp to 'add' a set with a non-set value", 2)   --error第二个参数的含义P116
    end]]
    local res = Set.new({});
    for k in pairs(a) do res[k] = k; end
    for k in pairs(b) do res[k] = k; end
    return res
end
 
s1 = Set.new{70, 90, 30, 80}
s2 = Set.new{30, 3}
--print(getmetatable(s1))
--print(getmetatable(s2))
 
mt.__add = Set.union;
 
s3 = s1 + s2;
Set.print(s3);

--============================================
--4 table访问的元方法=========================

--__index有关继承的典型示例
Window = {}
Window.prototype = {x = 0, y = 0, width = 100, height}
Window.mt = {}
 
function Window.new(o)
    setmetatable(o, Window.mt)
    return o
end
 
Window.mt.__index = function (table, key)
    return Window.prototype[key]
end
 
w = Window.new{x = 10, y = 20}
print("=======================================");
print(w.width)
 
--__index修改table默认值
function setDefault (t, d)
    local mt = {__index = function () return d end}
    setmetatable(t, mt)
end
 
tab = {x = 10, y = 20}
print(tab.x, tab.z);
setDefault(tab, 0);
print(tab.x, tab.z);

print("*****************");
--13.4.5 只读的table
function readOnly(t)
    local proxy = {}
    local mt = {
    __index = t,
    __newindex = function(t, k, v)
        --error("attempt to update a read-only table", 2)
    end
    }
    setmetatable(proxy, mt)
    return proxy
end
 
days = readOnly{"Sunday", "Monday", "Tuesday", "W", "T", "F", "S"}
print(days[1])
 days[2] = "Noday"
print("##########");
 --error("hello word!",5);

local ev={};
function ev.__call()
  print "called from ev"
end

setmetatable(ev, ev)

-- test it
ev();


temp = Set.new(os.date("*t", 906000490));
Set.print(temp);
--print(temp);



print(os.date("%x", 906000490));
print(type(temp));

local x = os.clock()
local s = 0
for i=1,100000 do s = s + i end
print(string.format("elapsed time: %.2f\n", os.clock() - x));


print("SSSSSSSSSSSSSSSSSSSSSSSS");

local omnitureMapping = {
    --couponlist 短信点击
    smsClick_cl ={event='event24',eVars={{id='eVar38',value='BBPListMessage'}}},
    --BBP 详细信息短信点击 
    smsClick_pf = {event='event24',eVars={{id='eVar38',value='BBPProfileMessage'}}},
    --BBP 辅导老师短信点击
    smsClick_re = {event='event24',eVars={{id='eVar38',value='BBPRecruiterMessage'}}},
    --竞赛 短信
    smsClick_co = {event='event24',eVars={{id='eVar37',value='ContestListMessage'}}},
    -- list 微信点击
    weChatClick_cl = {event='event25',eVars={{id='eVar39',value='BBPListWeChat'}}},
    -- banner 微信点击
    weChatClick_bn = {event='event25',eVars={{id='eVar39',value='BBPBannerWeChat'}}},
    -- 个人信息微信点击
    weChatClick_pf = {event='event25',eVars={{id='eVar39',value='BBPProfileWeChat'}}},
    -- 辅导老师微信点击
    weChatClick_re = {event='event25',eVars={{id='eVar39',value='BBPRecruiterWeChat'}}},
    -- 竞赛电话点击
    callClick_co =  {event='event23',eVars={{id='eVar42',value='ContestListCall'}}},
    --BBP List 电话点击
    callClick_cl =  {event='event23',eVars={{id='eVar43',value='BBPListCall'}}},
    --BBP 个人信息 电话点击
    callClick_pf =  {event='event23',eVars={{id='eVar43',value='BBPProfileCall'}}},
    --BBP 辅导老师 电话点击
    callClick_re =  {event='event23',eVars={{id='eVar43',value='BBPRecruiterCall'}}},
    --分享渠道 微信
    ShareClick_weChat = {event='event26',eVars={{id='eVar44',value='WeChat'}}},
    --分享渠道 朋友圈
    ShareClick_friends = {event='event26',eVars={{id='eVar44',value='WeChatMoments'}}},
    --分享渠道 微博
    ShareClick_weBo = {event='event26',eVars={{id='eVar44',value='WeBo'}}},
    --筛选 全部
    filterClick_all = {event='event5',eVars={{id='eVar40',value='ALL'}}},
    --筛选 本月过期
    filterClick_thisMonth = {event='event5',eVars={{id='eVar40',value='ThisMonthExpired'}}},
    --筛选   下个月过期
    filterClick_nextMonth = {event='event5',eVars={{id='eVar40',value='NextMonthExpired'}}},
    --筛选 新顾客未获得
    filterClick_notHave = {event='event5',eVars={{id='eVar40',value='NewVIPNotget'}}},
    --筛选 本月使用
    filterClick_useed = {event='event5',eVars={{id='eVar40',value='ThisMonthUsed'}}},
    --筛选 鼓励获得
    filterClick_more = {event='event5',eVars={{id='eVar40',value='NoCoupon'}}},
    --筛选 800Coupon
    filterClick_800Coupon = {event='event5',eVars={{id='eVar40',value='800Coupon'}}},
    --筛选 1000Coupon
    filterClick_1000Coupon = {event='event5',eVars={{id='eVar40',value='1000Coupon'}}},
    --排序 姓名
    sortClick_name =  {event='event6',eVars={{id='eVar41',value='ByName'}}},
    --排序 获得日期
    sortClick_getDate =  {event='event6',eVars={{id='eVar41',value='ByCouponDate'}}},
    --排序 辅导老师
    sortClick_recruiter =  {event='event6',eVars={{id='eVar41',value='ByRecruiter'}}},
    --排序 加入日期
    sortClick_joinDate =  {event='event6',eVars={{id='eVar41',value='ByJoinDate'}}},
    --排序 订单日期
    sortClick_orderDate =  {event='event6',eVars={{id='eVar41',value='ByOrderDate'}}}
    
}
local eVars = omnitureMapping['sortClick_orderDate'].eVars;
  if eVars then
      for k,v in ipairs(eVars) do
         print("v.id:",v.id,"v.value:",v.value)
      end
    end




