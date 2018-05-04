--- @type StdUi
local StdUi = LibStub and LibStub('StdUi', true);

StdUi.config = {};

function StdUi:ResetConfig()
	self.config = {
		font     = {
			familly       = 'Fonts\\FRIZQT__.TTF',
			size          = 12,
			effect        = 'OUTLINE',
			strata        = 'OVERLAY',
			color         = { r = 1, g = 1, b = 1, a = 1 },
			colorDisabled = { r = 0.25, g = 0.25, b = 0.25, a = 1 },
		},

		backdrop = {
			panel          = { r = 0.10, g = 0.10, b = 0.10, a = 1 },

			button         = { r = 0.25, g = 0.25, b = 0.25, a = 1 },
			buttonDisabled = { r = 0.15, g = 0.15, b = 0.15, a = 1 },

			border         = { r = 0.80, g = 0.80, b = 0.80, a = 1 },
			borderDisabled = { r = 0.40, g = 0.40, b = 0.40, a = 1 }
		},

		highlight = {
			color = { r = 1, g = 0.9, b = 0, a = 0.4 }
		},

		dialog   = {
			width  = 400,
			height = 100,
			button = {
				width  = 100,
				height = 20,
				margin = 5
			}
		}
	};
end
StdUi:ResetConfig();

function StdUi:SetDefaultFont(font, size, effect, strata)
	self.config.font.familly = font;
	self.config.font.size = size;
	self.config.font.effect = effect;
	self.config.font.strata = strata;
end