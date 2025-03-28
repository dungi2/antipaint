local toggled = true

local function removePaintParts()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "BucketPaint" or obj.Name == "ToiletWhite" or obj.Name == "ToiletGold" then
            for _, ppp in pairs(obj:GetChildren()) do
                if ppp.Name == "PaintPlayerPart" then
                    ppp:Destroy()
                end
            end
        end
    end
end

local function onDescendantAdded(obj)
    if toggled and (obj.Name == "BucketPaint" or obj.Name == "ToiletWhite" or obj.Name == "ToiletGold") then
        task.wait()
        local destroyCount = obj.Name == "BucketPaint" and 6 or 5
        for i = 1, destroyCount do
            local ppp = obj:WaitForChild("PaintPlayerPart", 2) -- 최대 2초까지 기다림
            if ppp then
                ppp:Destroy()
            end
            task.wait()
        end
    end
end

workspace.DescendantAdded:Connect(onDescendantAdded)

game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5) -- 리스폰 후 0.5초 대기 (더 빠르게 적용)
        removePaintParts()
    end)
end)

removePaintParts() -- 스크립트 실행 시 즉시 제거
