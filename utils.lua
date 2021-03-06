function AuctionFaster:FormatDuration(duration)
	if duration >= 172800 then
		return format('%.1f %s', duration/86400, 'days ago')
	elseif duration >= 7200 then
		return format('%.1f %s', duration/3600, 'hours ago')
	else
		return format('%.1f %s', duration/60, 'minutes ago')
	end
end

function AuctionFaster:FormatAuctionDuration(duration)
	if duration == 1 then
		return '12h';
	elseif duration == 2 then
		return '24h';
	elseif duration == 3 then
		return '48h';
	else
		return '---';
	end
end

function AuctionFaster:TableCombine(keys, values)
	local result = {};
	for i = 1, #keys do
		result[keys[i]] = values[i];
	end

	return result;
end

function AuctionFaster:ShowTooltip(frame, link, show, itemId, anchor)
	if show then

		GameTooltip:SetOwner(frame);
		GameTooltip:SetPoint(anchor or 'TOPLEFT');

		if itemId == 82800 then
			local _, speciesID, level, breedQuality, maxHealth, power, speed, battlePetID = strsplit(':', link);

			BattlePetToolTip_Show(
				tonumber(speciesID),
				tonumber(level),
				tonumber(breedQuality),
				tonumber(maxHealth),
				tonumber(power),
				tonumber(speed),
				string.gsub(string.gsub(link, '^(.*)%[', ''), '%](.*)$', '')
			);
			BattlePetTooltip:ClearAllPoints();
			BattlePetTooltip:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT', 0, 0);
		else
			GameTooltip:SetHyperlink(link);
			GameTooltip:Show();
		end
	else
		GameTooltip:Hide();
	end
end