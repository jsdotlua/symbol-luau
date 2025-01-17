--!strict
--[[
	Tests in this file are from the Symbol code in Roact:
	https://github.com/Roblox/roact/blob/v1.3.1/src/Symbol.spec.lua

	and from interpretation of this spec:
	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol
]]
local Symbol = require("../Symbol")
local GlobalRegistry = require("../Registry.global.lua")

local JestGlobals = require("@pkg/jest-globals")
local expect = JestGlobals.expect
local describe = JestGlobals.describe
local it = JestGlobals.it
local beforeEach = JestGlobals.beforeEach

describe("New symbols", function()
	it("should give an opaque object", function()
		local symbol = Symbol("foo")

		expect(typeof(symbol)).toEqual("userdata")
	end)

	it("should coerce to a default name if none is given", function()
		local symbol = Symbol()

		expect(tostring(symbol)).toEqual("Symbol()")
	end)

	it("should coerce to the given name", function()
		local symbol = Symbol("foo")

		expect(tostring(symbol)).toEqual("Symbol(foo)")
	end)

	it("should be unique when constructed", function()
		local symbolA = Symbol("abc")
		local symbolB = Symbol("abc")

		expect(symbolA).never.toEqual(symbolB)
	end)
end)

describe("Global registry", function()
	beforeEach(function()
		GlobalRegistry.__clear()
	end)

	it("should return a symbol for items referenced for the first time", function()
		local fooSymbol = Symbol.for_("foo")
		local barSymbol = Symbol.for_("bar")

		expect(typeof(fooSymbol)).toEqual(typeof(Symbol()))
		expect(tostring(fooSymbol)).toEqual("Symbol(foo)")
		expect(typeof(barSymbol)).toEqual(typeof(Symbol()))
		expect(tostring(barSymbol)).toEqual("Symbol(bar)")
	end)

	it("should return the same symbol object for the same string", function()
		local fooSymbol1 = Symbol.for_("foo")
		local fooSymbol2 = Symbol.for_("foo")

		expect(fooSymbol1).toEqual(fooSymbol2)
	end)
end)
