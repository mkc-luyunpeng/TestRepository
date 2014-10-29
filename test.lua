Union = {  
    data = nil,  
    dirty = nil,  
}  

print('self=',self);
--- 生成新的对象  
function Union:new(o)  
    o = o or {}  
    setmetatable(o,self)  
    self.__index = self；
    return o  
end  
--- 初始化Union数据  
function Union:init(data)  
    self:initTable()  
    self.data = data  
    local meta = {}  
    meta.__index = function (table, key)  
        if Union[key] ~= nil then  
            return Union[key]  
        else  
            return self.data[key]  
        end  
    end  
    meta.__newindex = function(table,key, value)  
        self.data[key] = value  
    end  
    setmetatable(self, meta)  
end  
function Union:initTable()  
    if self.data == nil then  
        self.data = {}  
    end  
    if self.dirty == nil then  
        self.dirty = {}  
    end  
end  
function Union:print()  
    print(self.point, self.data.point)  
end  
function pt()  
    print(data1.point, data2.point, u.point, u.data.point)  
end  
u = Union:new()  
data1 = {point = 3}  
data2 = {point = 103}  
u:init(data1)  
pt()  
u.point = 4  
pt()  
u.data = data2  
pt()  
u.point = 104  
pt()  

 
 
 
通过修改__index和__newindex会获得不同的结果。
 
1.正确结果
[c-sharp] view plaincopyprint?
function Union:init(data)  
    self:initTable()  
    self.data = data  
    local meta = {}  
    meta.__index = function (table, key)  
        if Union[key] ~= nil then  
            return Union[key]  
        else  
            return self.data[key]  
        end  
    end  
    meta.__newindex = function(table,key, value)  
        self.data[key] = value  
    end  
    setmetatable(self, meta)  
end  
3    103    3    3
4    103    4    4
4    103    103    103
4    104    104    104
 
2.错误的__newindex
[c-sharp] view plaincopyprint?
function Union:init(data)  
    self:initTable()  
    self.data = data  
    local meta = {}  
    meta.__index = function (table, key)  
        if Union[key] ~= nil then  
            return Union[key]  
        else  
            return self.data[key]  
        end  
    end  
    meta.__newindex = self.data  
    setmetatable(self, meta)  
end  
3    103    3    3
4    103    4    4
4    103    103    103
104    103    103    103
3.错误的__index
[c-sharp] view plaincopyprint?
function Union:init(data)  
    self:initTable()  
    self.data = data  
    local meta = {}  
    meta.__index = function (table, key)  
        if Union[key] ~= nil then  
            return Union[key]  
        else  
            return data[key]  
        end  
    end  
    meta.__newindex = function(table,key, value)  
        self.data[key] = value  
    end  
    setmetatable(self, meta)  
end  