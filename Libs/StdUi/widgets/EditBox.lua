--- @type StdUi
local StdUi = LibStub and LibStub('StdUi', true);
if not StdUi then
	return;
end

--- @return EditBox
function StdUi:EditBox(parent, width, height, text, validator)
	validator = validator or StdUi.Util.editBoxValidator;

	local editBox = CreateFrame('EditBox', nil, parent);
	editBox:SetTextInsets(3, 3, 3, 3);
	editBox:SetMaxLetters(256);
	editBox:SetFontObject(ChatFontNormal);
	editBox:SetAutoFocus(false);

	editBox:SetScript('OnEscapePressed', function (self)
		self:ClearFocus();
	end);

	function editBox:IsValid()
		return self.isValid;
	end;

	function editBox:Validate()
		self.isValidated = true;
		self.isValid = validator(self);

		if self.OnValueChanged then
			self.OnValueChanged(self);
		end
		self.isValidated = false;
	end;

	local button = self:Button(editBox, 40, height - 4, 'OK');
	button:SetPoint('RIGHT', -2, 0);
	button:Hide();
	button.editBox = editBox;
	editBox.button = button;

	button:SetScript('OnClick', function(self)
		self.editBox:Validate(self.editBox);
	end);

	editBox:SetScript('OnEnterPressed', function(self)
		self:Validate();
	end)

	editBox:SetScript('OnTextChanged', function(self, isUserInput)
		local value = StdUi.Util.stripColors(self:GetText());
		if tostring(value) ~= tostring(self.lastValue) then
			self.lastValue = value;
			if not self.isValidated and self.button and isUserInput then
				self.button:Show();
			end
		end
	end);

	self:ApplyBackdrop(editBox);
	self:SetObjSize(editBox, width, height);

	if text then
		editBox:SetText(text);
	end

	self:ApplyDisabledBackdrop(editBox);

	return editBox;
end

function StdUi:NumericBox(parent, width, height, text, validator)
	validator = validator or self.Util.numericBoxValidator;

	local editBox = self:EditBox(parent, width, height, text, validator);
	editBox:SetNumeric(true);

	function editBox:GetValue()
		return self.value;
	end;

	function editBox:SetValue(value)
		self.value = value;
		self:SetText(value);
		self:Validate();
		self.button:Hide();
	end;

	function editBox:SetMaxValue(value)
		self.maxValue = value;
		self:Validate();
	end;

	function editBox:SetMinValue(value)
		self.minValue = value;
		self:Validate();
	end;

	return editBox;
end

function StdUi:MoneyBox(parent, width, height, text, validator)
	validator = validator or self.Util.moneyBoxValidator;

	local editBox = self:EditBox(parent, width, height, text, validator);
	editBox:SetMaxLetters(20);

	function editBox:GetValue()
		return self.value;
	end;

	local formatMoney = StdUi.Util.formatMoney;
	function editBox:SetValue(value)
		self.value = value;
		local formatted = formatMoney(value);
		self:SetText(formatted);
		self:Validate();
		self.button:Hide();
	end;

	return editBox;
end

function StdUi:EditBoxWithLabel(parent, width, height, text, label, labelPosition, labelWidth)
	local editBox = self:EditBox(parent, width, height, text);
	self:AddLabel(parent, editBox, label, labelPosition, labelWidth);

	return editBox;
end


function StdUi:NumericBoxWithLabel(parent, width, height, text, label, labelPosition, labelWidth)
	local editBox = self:NumericBox(parent, width, height, text);
	self:AddLabel(parent, editBox, label, labelPosition, labelWidth);

	return editBox;
end

function StdUi:MoneyBoxWithLabel(parent, width, height, text, label, labelPosition, labelWidth)
	local editBox = self:MoneyBox(parent, width, height, text);
	self:AddLabel(parent, editBox, label, labelPosition, labelWidth);

	return editBox;
end