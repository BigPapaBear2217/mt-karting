local QBCore = exports['qb-core']:GetCoreObject()

local function HasMoney(pMoney, amount)
    local cash = pMoney.cash
    local bank = pMoney.bank
    local b = cash and bank and (cash >= amount or bank >= amount)
    return b, (cash>=amount and "cash" or "bank")
end

QBCore.Functions.CreateCallback("mt-karting:server:BuyTicket", function (source, cb, ticket)
    local player = QBCore.Functions.GetPlayer(source)
    local price = Config['Tickets'][ticket]['price']
    local hasMoney, acc = HasMoney(player.PlayerData.money, price)
    if not hasMoney then cb(false); return end
    if not player.Functions.RemoveMoney(acc, price, "Ticket") then cb(false); return end
    cb(true)
end)