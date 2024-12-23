buttonClass = {}
buttonClass.__index = buttonClass

function buttonClass:new(id,status,x,w,y,h,r1,r2,bgcolor,fcolor,abgcolor,afcolor,image1,image2,scale,ix,iy,font,text,tx,ty,tcolor,atcolor,limit,align)
    local self = {}
    setmetatable(self,buttonClass)
    self.id = id
    self.status = status
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r1 = r1
    self.r2 = r2
    self.scale = scale
    self.ix = ix
    self.iy = iy
    self.font = font
    self.text = text
    self.defaulttext = text
    self.tx = tx
    self.ty = ty
    self.limit = limit
    self.align = align
    self.tcolor = tcolor
    self.atcolor = atcolor
    if status == true then
        self.bgcolor = abgcolor
        self.fcolor = afcolor
        self.abgcolor = bgcolor
        self.afcolor = fcolor
        self.image1 = image2
        self.image2 = image1
    else
        self.bgcolor = bgcolor
        self.fcolor = fcolor
        self.abgcolor = abgcolor
        self.afcolor = afcolor
        self.image1 = image1
        self.image2 = image2
    end
    return self
end

function buttonClass:render(x,y)
    love.graphics.setColor(1,1,1,1)
    if self.image1 ~= nil then
        if self.ix == nil or self.iy == nil then
            love.graphics.draw(self.image1,self.x+x,self.y+y,self.r1,self.scale,self.scale)
        else
            love.graphics.draw(self.image1,self.ix+x,self.iy+y,self.r1,self.scale,self.scale)
        end
    else
        love.graphics.setColor(self.bgcolor)
        love.graphics.rectangle("fill",self.x+x,self.y+y,self.w,self.h,self.r1,self.r2)
        love.graphics.setColor(self.fcolor)
        love.graphics.rectangle("line",self.x+x,self.y+y,self.w,self.h,self.r1,self.r2)
    end
    if self.text ~= nil then
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.tcolor)
        local textheight = self.font:getHeight(self.text)/2
        local textwidth = self.font:getWidth(self.text)/2
        if self.tx == nil or self.ty == nil then
            for m = 1,-1,-1 do
                for n = 1,-1,-1 do
                    if m ~= 0 and n ~= 0 then
                        love.graphics.printf(self.text, self.x+m+x, self.y+n+y, self.limit, self.align, 0, 1, 1, 0, textheight, 0, 0)
                    end
                end
            end
            if self.text == self.defaulttext then
                love.graphics.setColor(self.atcolor)
            else
                love.graphics.setColor({1,1,1})
            end
            love.graphics.printf(self.text, self.x+x, self.y+y, self.limit, self.align, 0, 1, 1, 0, textheight, 0, 0)
        else
            for m = 1,-1,-1 do
                for n = 1,-1,-1 do
                    if m ~= 0 and n ~= 0 then
                        love.graphics.printf(self.text, self.tx+m+x, self.ty+n+y, self.limit, self.align, 0, 1, 1, 0, textheight, 0, 0)
                    end
                end
            end
            if self.text == self.defaulttext then
                love.graphics.setColor(self.atcolor)
            else
                love.graphics.setColor({1,1,1})
            end
            love.graphics.printf(self.text, self.tx+x, self.ty+y, self.limit, self.align, 0, 1, 1, 0, textheight, 0, 0)
        end
    end
end

function buttonClass:input(x,y,input,sx,sy)
    return x > self.x+sx and x < self.x+self.w+sx and y > self.y+sy and y < self.y+self.h+sy and input.x > self.x+sx and input.x < self.x+self.w+sx and input.y > self.y+sy and input.y < self.y+self.h+sy
end

function buttonClass:updateImage(image1,scale,ix,iy)
    self.image1 = image1
    self.scale = scale
    self.ix = ix
    self.iy = iy
end

function buttonClass:updateColor(bgcolor,fcolor,tcolor)
    self.bgcolor = bgcolor
    self.fcolor = fcolor
    self.tcolor = tcolor
end

function buttonClass:updateText(text)
    if text == '' and self.status == false then
        self.text = self.defaulttext
    else
        self.text = text
    end
end

function buttonClass:updateStatus(newstatus)
    if self.status ~= newstatus then
        self.status = not self.status
        self.bgcolor, self.abgcolor = self.abgcolor, self.bgcolor
        self.fcolor, self.afcolor = self.afcolor, self.fcolor
        self.image1, self.image2 = self.image2, self.image1
    end
end

function buttonClass:getID()
    return self.id
end

function buttonClass:setTextInput(enable)
    love.keyboard.setTextInput(enable, self.x, self.y, self.w, self.h)
    if self.status ~= enable then
        self.status = not self.status
        self.bgcolor, self.abgcolor = self.abgcolor, self.bgcolor
        self.fcolor, self.afcolor = self.afcolor, self.fcolor
        self.image1, self.image2 = self.image2, self.image1
    end
end