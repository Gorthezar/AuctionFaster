--- @type StdUi
local StdUi = LibStub and LibStub('StdUi', true);
local SquarewButtonCoords = {
	["UP"] = {     0.45312500,    0.64062500,     0.01562500,     0.20312500};
	["DOWN"] = {   0.45312500,    0.64062500,     0.20312500,     0.01562500};
	["LEFT"] = {   0.23437500,    0.42187500,     0.01562500,     0.20312500};
	["RIGHT"] = {  0.42187500,    0.23437500,     0.01562500,     0.20312500};
	["DELETE"] = { 0.01562500,    0.20312500,     0.01562500,     0.20312500};
};

function StdUi:SquareButton(parent, width, height, icon)
	local button = CreateFrame('Button', nil, parent)
	self:SetObjSize(button, width, height);
	button.icon = self:Texture(button, button:GetWidth(), button:GetHeight(),
			'Interface\\Buttons\\SquareButtonTextures');

	local coords = SquarewButtonCoords[icon];
	if coords then
		button.icon:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
	end

	return button;
end

function StdUi:PanelButton(parent, width, height, text)
	local button = CreateFrame('Button', nil, parent, 'UIPanelButtonTemplate');
	self:SetObjSize(button, width, height);
	if text then
		button:SetText(text);
	end

	return button;
end

function StdUi:ButtonLabel(parent, text)
	local label = self:Label(parent, text);
	label:SetJustifyH('CENTER');
	self:GlueAcross(label, parent, 2, -2, -2, 2);
	parent:SetFontString(label);

	return label;
end

function StdUi:HighlightButtonTexture(button)
	local hTex = self:Texture(button, nil, nil, nil);
	hTex:SetColorTexture(
			self.config.highlight.color.r,
			self.config.highlight.color.g,
			self.config.highlight.color.b,
			self.config.highlight.color.a
	);
	hTex:SetAllPoints();

	return hTex;
end

--- Creates a button with only a highlight
--- @return Button
function StdUi:HighlightButton(parent, width, height, text)
	local button = CreateFrame('Button', nil, parent)
	self:SetObjSize(button, width, height);
	button.text = self:ButtonLabel(button, text);

	local hTex = self:HighlightButtonTexture(button);

	button:SetHighlightTexture(hTex);
	button.highlightTexture = hTex;

	return button;
end

--- @return Button
function StdUi:Button(parent, width, height, text)
	local button = CreateFrame('Button', nil, parent)
	self:SetObjSize(button, width, height);
	button.text = self:ButtonLabel(button, text);

	self:ApplyBackdrop(button);

	local hTex = self:HighlightButtonTexture(button);

	button:SetHighlightTexture(hTex);
	button.highlightTexture = hTex;

	self:ApplyDisabledBackdrop(button);
	return button;
end

function StdUi:ApplyDisabledBackdrop(button)
	hooksecurefunc(button, 'Disable', function(self)
		StdUi:ApplyBackdrop(self, 'buttonDisabled', 'borderDisabled');
		if self.label then
			StdUi:SetTextColor(self.label, 'colorDisabled');
		end

		if self.text then
			StdUi:SetTextColor(self.text, 'colorDisabled');
		end
	end);

	hooksecurefunc(button, 'Enable', function(self)
		StdUi:ApplyBackdrop(self, 'button', 'border');
		if self.label then
			StdUi:SetTextColor(self.label, 'color');
		end

		if self.text then
			StdUi:SetTextColor(self.text, 'color');
		end
	end);
end


function StdUi:ActionButton(parent)
	-- NYI
end