import json

# JSON como cadena de texto
json_data = '''
[
	{
		"_id": "621baa7068878f576568a904",
		"loc": [-70.51867, -33.486270000000005],
		"lat": -33.486270000000005,
		"lon": -70.51867,
		"sequence": 0
	},
	{
		"_id": "621baa7068878f576568a905",
		"loc": [-70.51867, -33.48631],
		"lat": -33.48631,
		"lon": -70.51867,
		"sequence": 1
	},
	{
		"_id": "621baa7068878f576568a906",
		"loc": [-70.51873, -33.48633],
		"lat": -33.48633,
		"lon": -70.51873,
		"sequence": 2
	},
	{
		"_id": "621baa7068878f576568a907",
		"loc": [-70.51877, -33.486360000000005],
		"lat": -33.486360000000005,
		"lon": -70.51877,
		"sequence": 3
	},
	{
		"_id": "621baa7068878f576568a908",
		"loc": [-70.51881, -33.486430000000006],
		"lat": -33.486430000000006,
		"lon": -70.51881,
		"sequence": 4
	},
	{
		"_id": "621baa7068878f576568a909",
		"loc": [-70.51907, -33.48688],
		"lat": -33.48688,
		"lon": -70.51907,
		"sequence": 5
	},
	{
		"_id": "621baa7068878f576568a90a",
		"loc": [-70.51925, -33.48718],
		"lat": -33.48718,
		"lon": -70.51925,
		"sequence": 6
	},
	{
		"_id": "621baa7068878f576568a90b",
		"loc": [-70.51929000000001, -33.48724],
		"lat": -33.48724,
		"lon": -70.51929000000001,
		"sequence": 7
	},
	{
		"_id": "621baa7068878f576568a90c",
		"loc": [-70.51938000000001, -33.487410000000004],
		"lat": -33.487410000000004,
		"lon": -70.51938000000001,
		"sequence": 8
	},
	{
		"_id": "621baa7068878f576568a90d",
		"loc": [-70.51942000000001, -33.48753],
		"lat": -33.48753,
		"lon": -70.51942000000001,
		"sequence": 9
	},
	{
		"_id": "621baa7068878f576568a90e",
		"loc": [-70.51943, -33.48758],
		"lat": -33.48758,
		"lon": -70.51943,
		"sequence": 10
	},
	{
		"_id": "621baa7068878f576568a90f",
		"loc": [-70.51944, -33.48778],
		"lat": -33.48778,
		"lon": -70.51944,
		"sequence": 11
	},
	{
		"_id": "621baa7068878f576568a910",
		"loc": [-70.51942000000001, -33.48787],
		"lat": -33.48787,
		"lon": -70.51942000000001,
		"sequence": 12
	},
	{
		"_id": "621baa7068878f576568a911",
		"loc": [-70.51938000000001, -33.48794],
		"lat": -33.48794,
		"lon": -70.51938000000001,
		"sequence": 13
	},
	{
		"_id": "621baa7068878f576568a912",
		"loc": [-70.51932000000001, -33.487970000000004],
		"lat": -33.487970000000004,
		"lon": -70.51932000000001,
		"sequence": 14
	},
	{
		"_id": "621baa7068878f576568a913",
		"loc": [-70.51929000000001, -33.48798],
		"lat": -33.48798,
		"lon": -70.51929000000001,
		"sequence": 15
	},
	{
		"_id": "621baa7068878f576568a914",
		"loc": [-70.51929000000001, -33.488040000000005],
		"lat": -33.488040000000005,
		"lon": -70.51929000000001,
		"sequence": 16
	},
	{
		"_id": "621baa7068878f576568a915",
		"loc": [-70.51916, -33.488400000000006],
		"lat": -33.488400000000006,
		"lon": -70.51916,
		"sequence": 17
	},
	{
		"_id": "621baa7068878f576568a916",
		"loc": [-70.51905000000001, -33.488580000000006],
		"lat": -33.488580000000006,
		"lon": -70.51905000000001,
		"sequence": 18
	},
	{
		"_id": "621baa7068878f576568a917",
		"loc": [-70.51892000000001, -33.488730000000004],
		"lat": -33.488730000000004,
		"lon": -70.51892000000001,
		"sequence": 19
	},
	{
		"_id": "621baa7068878f576568a918",
		"loc": [-70.51885, -33.488800000000005],
		"lat": -33.488800000000005,
		"lon": -70.51885,
		"sequence": 20
	},
	{
		"_id": "621baa7068878f576568a919",
		"loc": [-70.51881, -33.48886],
		"lat": -33.48886,
		"lon": -70.51881,
		"sequence": 21
	},
	{
		"_id": "621baa7068878f576568a91a",
		"loc": [-70.51874000000001, -33.48897],
		"lat": -33.48897,
		"lon": -70.51874000000001,
		"sequence": 22
	},
	{
		"_id": "621baa7068878f576568a91b",
		"loc": [-70.51867, -33.489140000000006],
		"lat": -33.489140000000006,
		"lon": -70.51867,
		"sequence": 23
	},
	{
		"_id": "621baa7068878f576568a91c",
		"loc": [-70.51867, -33.489140000000006],
		"lat": -33.489140000000006,
		"lon": -70.51867,
		"sequence": 24
	},
	{
		"_id": "621baa7068878f576568a91d",
		"loc": [-70.51830000000001, -33.489110000000004],
		"lat": -33.489110000000004,
		"lon": -70.51830000000001,
		"sequence": 25
	},
	{
		"_id": "621baa7068878f576568a91e",
		"loc": [-70.51823, -33.48912],
		"lat": -33.48912,
		"lon": -70.51823,
		"sequence": 26
	},
	{
		"_id": "621baa7068878f576568a91f",
		"loc": [-70.51806, -33.489160000000005],
		"lat": -33.489160000000005,
		"lon": -70.51806,
		"sequence": 27
	},
	{
		"_id": "621baa7068878f576568a920",
		"loc": [-70.51791, -33.48921],
		"lat": -33.48921,
		"lon": -70.51791,
		"sequence": 28
	},
	{
		"_id": "621baa7068878f576568a921",
		"loc": [-70.51779, -33.48924],
		"lat": -33.48924,
		"lon": -70.51779,
		"sequence": 29
	},
	{
		"_id": "621baa7068878f576568a922",
		"loc": [-70.51765, -33.48924],
		"lat": -33.48924,
		"lon": -70.51765,
		"sequence": 30
	},
	{
		"_id": "621baa7068878f576568a923",
		"loc": [-70.51747, -33.489200000000004],
		"lat": -33.489200000000004,
		"lon": -70.51747,
		"sequence": 31
	},
	{
		"_id": "621baa7068878f576568a924",
		"loc": [-70.51738, -33.48917],
		"lat": -33.48917,
		"lon": -70.51738,
		"sequence": 32
	},
	{
		"_id": "621baa7068878f576568a925",
		"loc": [-70.5172, -33.48913],
		"lat": -33.48913,
		"lon": -70.5172,
		"sequence": 33
	},
	{
		"_id": "621baa7068878f576568a926",
		"loc": [-70.51700000000001, -33.489070000000005],
		"lat": -33.489070000000005,
		"lon": -70.51700000000001,
		"sequence": 34
	},
	{
		"_id": "621baa7068878f576568a927",
		"loc": [-70.51679, -33.48901],
		"lat": -33.48901,
		"lon": -70.51679,
		"sequence": 35
	},
	{
		"_id": "621baa7068878f576568a928",
		"loc": [-70.51671, -33.48901],
		"lat": -33.48901,
		"lon": -70.51671,
		"sequence": 36
	},
	{
		"_id": "621baa7068878f576568a929",
		"loc": [-70.5163, -33.489070000000005],
		"lat": -33.489070000000005,
		"lon": -70.5163,
		"sequence": 37
	},
	{
		"_id": "621baa7068878f576568a92a",
		"loc": [-70.5163, -33.489070000000005],
		"lat": -33.489070000000005,
		"lon": -70.5163,
		"sequence": 38
	},
	{
		"_id": "621baa7068878f576568a92b",
		"loc": [-70.51619000000001, -33.489470000000004],
		"lat": -33.489470000000004,
		"lon": -70.51619000000001,
		"sequence": 39
	},
	{
		"_id": "621baa7068878f576568a92c",
		"loc": [-70.51615000000001, -33.489670000000004],
		"lat": -33.489670000000004,
		"lon": -70.51615000000001,
		"sequence": 40
	},
	{
		"_id": "621baa7068878f576568a92d",
		"loc": [-70.51616, -33.48996],
		"lat": -33.48996,
		"lon": -70.51616,
		"sequence": 41
	},
	{
		"_id": "621baa7068878f576568a92e",
		"loc": [-70.51616, -33.48996],
		"lat": -33.48996,
		"lon": -70.51616,
		"sequence": 42
	},
	{
		"_id": "621baa7068878f576568a92f",
		"loc": [-70.51617, -33.48997],
		"lat": -33.48997,
		"lon": -70.51617,
		"sequence": 43
	},
	{
		"_id": "621baa7068878f576568a930",
		"loc": [-70.51618, -33.48998],
		"lat": -33.48998,
		"lon": -70.51618,
		"sequence": 44
	},
	{
		"_id": "621baa7068878f576568a931",
		"loc": [-70.51620000000001, -33.489990000000006],
		"lat": -33.489990000000006,
		"lon": -70.51620000000001,
		"sequence": 45
	},
	{
		"_id": "621baa7068878f576568a932",
		"loc": [-70.51621, -33.49],
		"lat": -33.49,
		"lon": -70.51621,
		"sequence": 46
	},
	{
		"_id": "621baa7068878f576568a933",
		"loc": [-70.51621, -33.49002],
		"lat": -33.49002,
		"lon": -70.51621,
		"sequence": 47
	},
	{
		"_id": "621baa7068878f576568a934",
		"loc": [-70.51622, -33.490030000000004],
		"lat": -33.490030000000004,
		"lon": -70.51622,
		"sequence": 48
	},
	{
		"_id": "621baa7068878f576568a935",
		"loc": [-70.51622, -33.490050000000004],
		"lat": -33.490050000000004,
		"lon": -70.51622,
		"sequence": 49
	},
	{
		"_id": "621baa7068878f576568a936",
		"loc": [-70.51621, -33.49006],
		"lat": -33.49006,
		"lon": -70.51621,
		"sequence": 50
	},
	{
		"_id": "621baa7068878f576568a937",
		"loc": [-70.51621, -33.490080000000006],
		"lat": -33.490080000000006,
		"lon": -70.51621,
		"sequence": 51
	},
	{
		"_id": "621baa7068878f576568a938",
		"loc": [-70.51620000000001, -33.49009],
		"lat": -33.49009,
		"lon": -70.51620000000001,
		"sequence": 52
	},
	{
		"_id": "621baa7068878f576568a939",
		"loc": [-70.51619000000001, -33.490100000000005],
		"lat": -33.490100000000005,
		"lon": -70.51619000000001,
		"sequence": 53
	},
	{
		"_id": "621baa7068878f576568a93a",
		"loc": [-70.51617, -33.490100000000005],
		"lat": -33.490100000000005,
		"lon": -70.51617,
		"sequence": 54
	},
	{
		"_id": "621baa7068878f576568a93b",
		"loc": [-70.51616, -33.49011],
		"lat": -33.49011,
		"lon": -70.51616,
		"sequence": 55
	},
	{
		"_id": "621baa7068878f576568a93c",
		"loc": [-70.51615000000001, -33.490120000000005],
		"lat": -33.490120000000005,
		"lon": -70.51615000000001,
		"sequence": 56
	},
	{
		"_id": "621baa7068878f576568a93d",
		"loc": [-70.51613, -33.490120000000005],
		"lat": -33.490120000000005,
		"lon": -70.51613,
		"sequence": 57
	},
	{
		"_id": "621baa7068878f576568a93e",
		"loc": [-70.51611000000001, -33.490120000000005],
		"lat": -33.490120000000005,
		"lon": -70.51611000000001,
		"sequence": 58
	},
	{
		"_id": "621baa7068878f576568a93f",
		"loc": [-70.51609, -33.49011],
		"lat": -33.49011,
		"lon": -70.51609,
		"sequence": 59
	},
	{
		"_id": "621baa7068878f576568a940",
		"loc": [-70.51605, -33.490170000000006],
		"lat": -33.490170000000006,
		"lon": -70.51605,
		"sequence": 60
	},
	{
		"_id": "621baa7068878f576568a941",
		"loc": [-70.51595, -33.490230000000004],
		"lat": -33.490230000000004,
		"lon": -70.51595,
		"sequence": 61
	},
	{
		"_id": "621baa7068878f576568a942",
		"loc": [-70.51585, -33.490300000000005],
		"lat": -33.490300000000005,
		"lon": -70.51585,
		"sequence": 62
	},
	{
		"_id": "621baa7068878f576568a943",
		"loc": [-70.51574000000001, -33.49035],
		"lat": -33.49035,
		"lon": -70.51574000000001,
		"sequence": 63
	},
	{
		"_id": "621baa7068878f576568a944",
		"loc": [-70.51555, -33.490410000000004],
		"lat": -33.490410000000004,
		"lon": -70.51555,
		"sequence": 64
	},
	{
		"_id": "621baa7068878f576568a945",
		"loc": [-70.51499000000001, -33.490640000000006],
		"lat": -33.490640000000006,
		"lon": -70.51499000000001,
		"sequence": 65
	},
	{
		"_id": "621baa7068878f576568a946",
		"loc": [-70.51489000000001, -33.490660000000005],
		"lat": -33.490660000000005,
		"lon": -70.51489000000001,
		"sequence": 66
	},
	{
		"_id": "621baa7068878f576568a947",
		"loc": [-70.51483, -33.49073],
		"lat": -33.49073,
		"lon": -70.51483,
		"sequence": 67
	},
	{
		"_id": "621baa7068878f576568a948",
		"loc": [-70.5147, -33.49076],
		"lat": -33.49076,
		"lon": -70.5147,
		"sequence": 68
	},
	{
		"_id": "621baa7068878f576568a949",
		"loc": [-70.5146, -33.490750000000006],
		"lat": -33.490750000000006,
		"lon": -70.5146,
		"sequence": 69
	},
	{
		"_id": "621baa7068878f576568a94a",
		"loc": [-70.51459000000001, -33.49074],
		"lat": -33.49074,
		"lon": -70.51459000000001,
		"sequence": 70
	},
	{
		"_id": "621baa7068878f576568a94b",
		"loc": [-70.51453000000001, -33.490680000000005],
		"lat": -33.490680000000005,
		"lon": -70.51453000000001,
		"sequence": 71
	},
	{
		"_id": "621baa7068878f576568a94c",
		"loc": [-70.51441000000001, -33.490660000000005],
		"lat": -33.490660000000005,
		"lon": -70.51441000000001,
		"sequence": 72
	},
	{
		"_id": "621baa7068878f576568a94d",
		"loc": [-70.51422000000001, -33.490660000000005],
		"lat": -33.490660000000005,
		"lon": -70.51422000000001,
		"sequence": 73
	},
	{
		"_id": "621baa7068878f576568a94e",
		"loc": [-70.51388, -33.490770000000005],
		"lat": -33.490770000000005,
		"lon": -70.51388,
		"sequence": 74
	},
	{
		"_id": "621baa7068878f576568a94f",
		"loc": [-70.51382000000001, -33.4908],
		"lat": -33.4908,
		"lon": -70.51382000000001,
		"sequence": 75
	},
	{
		"_id": "621baa7068878f576568a950",
		"loc": [-70.51375, -33.49085],
		"lat": -33.49085,
		"lon": -70.51375,
		"sequence": 76
	},
	{
		"_id": "621baa7068878f576568a951",
		"loc": [-70.51368000000001, -33.49094],
		"lat": -33.49094,
		"lon": -70.51368000000001,
		"sequence": 77
	},
	{
		"_id": "621baa7068878f576568a952",
		"loc": [-70.51364000000001, -33.49101],
		"lat": -33.49101,
		"lon": -70.51364000000001,
		"sequence": 78
	},
	{
		"_id": "621baa7068878f576568a953",
		"loc": [-70.51354, -33.49121],
		"lat": -33.49121,
		"lon": -70.51354,
		"sequence": 79
	},
	{
		"_id": "621baa7068878f576568a954",
		"loc": [-70.51342000000001, -33.49138],
		"lat": -33.49138,
		"lon": -70.51342000000001,
		"sequence": 80
	},
	{
		"_id": "621baa7068878f576568a955",
		"loc": [-70.51338000000001, -33.49143],
		"lat": -33.49143,
		"lon": -70.51338000000001,
		"sequence": 81
	},
	{
		"_id": "621baa7068878f576568a956",
		"loc": [-70.51335, -33.491490000000006],
		"lat": -33.491490000000006,
		"lon": -70.51335,
		"sequence": 82
	},
	{
		"_id": "621baa7068878f576568a957",
		"loc": [-70.51333000000001, -33.491530000000004],
		"lat": -33.491530000000004,
		"lon": -70.51333000000001,
		"sequence": 83
	},
	{
		"_id": "621baa7068878f576568a958",
		"loc": [-70.51332000000001, -33.491620000000005],
		"lat": -33.491620000000005,
		"lon": -70.51332000000001,
		"sequence": 84
	},
	{
		"_id": "621baa7068878f576568a959",
		"loc": [-70.51333000000001, -33.491690000000006],
		"lat": -33.491690000000006,
		"lon": -70.51333000000001,
		"sequence": 85
	},
	{
		"_id": "621baa7068878f576568a95a",
		"loc": [-70.51337000000001, -33.49176],
		"lat": -33.49176,
		"lon": -70.51337000000001,
		"sequence": 86
	},
	{
		"_id": "621baa7068878f576568a95b",
		"loc": [-70.5134, -33.491800000000005],
		"lat": -33.491800000000005,
		"lon": -70.5134,
		"sequence": 87
	},
	{
		"_id": "621baa7068878f576568a95c",
		"loc": [-70.51349, -33.491910000000004],
		"lat": -33.491910000000004,
		"lon": -70.51349,
		"sequence": 88
	},
	{
		"_id": "621baa7068878f576568a95d",
		"loc": [-70.51351000000001, -33.49194],
		"lat": -33.49194,
		"lon": -70.51351000000001,
		"sequence": 89
	},
	{
		"_id": "621baa7068878f576568a95e",
		"loc": [-70.51356000000001, -33.49201],
		"lat": -33.49201,
		"lon": -70.51356000000001,
		"sequence": 90
	},
	{
		"_id": "621baa7068878f576568a95f",
		"loc": [-70.51358, -33.4921],
		"lat": -33.4921,
		"lon": -70.51358,
		"sequence": 91
	},
	{
		"_id": "621baa7068878f576568a960",
		"loc": [-70.51358, -33.49215],
		"lat": -33.49215,
		"lon": -70.51358,
		"sequence": 92
	},
	{
		"_id": "621baa7068878f576568a961",
		"loc": [-70.51356000000001, -33.49226],
		"lat": -33.49226,
		"lon": -70.51356000000001,
		"sequence": 93
	},
	{
		"_id": "621baa7068878f576568a962",
		"loc": [-70.51349, -33.4924],
		"lat": -33.4924,
		"lon": -70.51349,
		"sequence": 94
	},
	{
		"_id": "621baa7068878f576568a963",
		"loc": [-70.51332000000001, -33.49255],
		"lat": -33.49255,
		"lon": -70.51332000000001,
		"sequence": 95
	},
	{
		"_id": "621baa7068878f576568a964",
		"loc": [-70.51320000000001, -33.492610000000006],
		"lat": -33.492610000000006,
		"lon": -70.51320000000001,
		"sequence": 96
	},
	{
		"_id": "621baa7068878f576568a965",
		"loc": [-70.51304, -33.49273],
		"lat": -33.49273,
		"lon": -70.51304,
		"sequence": 97
	},
	{
		"_id": "621baa7068878f576568a966",
		"loc": [-70.51293000000001, -33.492850000000004],
		"lat": -33.492850000000004,
		"lon": -70.51293000000001,
		"sequence": 98
	},
	{
		"_id": "621baa7068878f576568a967",
		"loc": [-70.51310000000001, -33.49268],
		"lat": -33.49268,
		"lon": -70.51310000000001,
		"sequence": 99
	},
	{
		"_id": "621baa7068878f576568a968",
		"loc": [-70.51328000000001, -33.49257],
		"lat": -33.49257,
		"lon": -70.51328000000001,
		"sequence": 100
	},
	{
		"_id": "621baa7068878f576568a969",
		"loc": [-70.51343, -33.492470000000004],
		"lat": -33.492470000000004,
		"lon": -70.51343,
		"sequence": 101
	},
	{
		"_id": "621baa7068878f576568a96a",
		"loc": [-70.51354, -33.49231],
		"lat": -33.49231,
		"lon": -70.51354,
		"sequence": 102
	},
	{
		"_id": "621baa7068878f576568a96b",
		"loc": [-70.51357, -33.49222],
		"lat": -33.49222,
		"lon": -70.51357,
		"sequence": 103
	},
	{
		"_id": "621baa7068878f576568a96c",
		"loc": [-70.51358, -33.492110000000004],
		"lat": -33.492110000000004,
		"lon": -70.51358,
		"sequence": 104
	},
	{
		"_id": "621baa7068878f576568a96d",
		"loc": [-70.51357, -33.492050000000006],
		"lat": -33.492050000000006,
		"lon": -70.51357,
		"sequence": 105
	},
	{
		"_id": "621baa7068878f576568a96e",
		"loc": [-70.51354, -33.49197],
		"lat": -33.49197,
		"lon": -70.51354,
		"sequence": 106
	},
	{
		"_id": "621baa7068878f576568a96f",
		"loc": [-70.51351000000001, -33.49193],
		"lat": -33.49193,
		"lon": -70.51351000000001,
		"sequence": 107
	},
	{
		"_id": "621baa7068878f576568a970",
		"loc": [-70.51345, -33.491870000000006],
		"lat": -33.491870000000006,
		"lon": -70.51345,
		"sequence": 108
	},
	{
		"_id": "621baa7068878f576568a971",
		"loc": [-70.51338000000001, -33.491780000000006],
		"lat": -33.491780000000006,
		"lon": -70.51338000000001,
		"sequence": 109
	},
	{
		"_id": "621baa7068878f576568a972",
		"loc": [-70.51334, -33.49172],
		"lat": -33.49172,
		"lon": -70.51334,
		"sequence": 110
	},
	{
		"_id": "621baa7068878f576568a973",
		"loc": [-70.51332000000001, -33.49166],
		"lat": -33.49166,
		"lon": -70.51332000000001,
		"sequence": 111
	},
	{
		"_id": "621baa7068878f576568a974",
		"loc": [-70.51332000000001, -33.491580000000006],
		"lat": -33.491580000000006,
		"lon": -70.51332000000001,
		"sequence": 112
	},
	{
		"_id": "621baa7068878f576568a975",
		"loc": [-70.51334, -33.491490000000006],
		"lat": -33.491490000000006,
		"lon": -70.51334,
		"sequence": 113
	},
	{
		"_id": "621baa7068878f576568a976",
		"loc": [-70.51336, -33.49147],
		"lat": -33.49147,
		"lon": -70.51336,
		"sequence": 114
	},
	{
		"_id": "621baa7068878f576568a977",
		"loc": [-70.5134, -33.49141],
		"lat": -33.49141,
		"lon": -70.5134,
		"sequence": 115
	},
	{
		"_id": "621baa7068878f576568a978",
		"loc": [-70.51345, -33.491330000000005],
		"lat": -33.491330000000005,
		"lon": -70.51345,
		"sequence": 116
	},
	{
		"_id": "621baa7068878f576568a979",
		"loc": [-70.51357, -33.49116],
		"lat": -33.49116,
		"lon": -70.51357,
		"sequence": 117
	},
	{
		"_id": "621baa7068878f576568a97a",
		"loc": [-70.51365000000001, -33.490990000000004],
		"lat": -33.490990000000004,
		"lon": -70.51365000000001,
		"sequence": 118
	},
	{
		"_id": "621baa7068878f576568a97b",
		"loc": [-70.51369000000001, -33.490930000000006],
		"lat": -33.490930000000006,
		"lon": -70.51369000000001,
		"sequence": 119
	},
	{
		"_id": "621baa7068878f576568a97c",
		"loc": [-70.51381, -33.4908],
		"lat": -33.4908,
		"lon": -70.51381,
		"sequence": 120
	},
	{
		"_id": "621baa7068878f576568a97d",
		"loc": [-70.51385, -33.49078],
		"lat": -33.49078,
		"lon": -70.51385,
		"sequence": 121
	},
	{
		"_id": "621baa7068878f576568a97e",
		"loc": [-70.51406, -33.49071],
		"lat": -33.49071,
		"lon": -70.51406,
		"sequence": 122
	},
	{
		"_id": "621baa7068878f576568a97f",
		"loc": [-70.51422000000001, -33.490660000000005],
		"lat": -33.490660000000005,
		"lon": -70.51422000000001,
		"sequence": 123
	},
	{
		"_id": "621baa7068878f576568a980",
		"loc": [-70.51448, -33.49067],
		"lat": -33.49067,
		"lon": -70.51448,
		"sequence": 124
	},
	{
		"_id": "621baa7068878f576568a981",
		"loc": [-70.51453000000001, -33.490680000000005],
		"lat": -33.490680000000005,
		"lon": -70.51453000000001,
		"sequence": 125
	},
	{
		"_id": "621baa7068878f576568a982",
		"loc": [-70.51489000000001, -33.490660000000005],
		"lat": -33.490660000000005,
		"lon": -70.51489000000001,
		"sequence": 126
	},
	{
		"_id": "621baa7068878f576568a983",
		"loc": [-70.51514, -33.4906],
		"lat": -33.4906,
		"lon": -70.51514,
		"sequence": 127
	},
	{
		"_id": "621baa7068878f576568a984",
		"loc": [-70.51563, -33.490320000000004],
		"lat": -33.490320000000004,
		"lon": -70.51563,
		"sequence": 128
	},
	{
		"_id": "621baa7068878f576568a985",
		"loc": [-70.51576, -33.49022],
		"lat": -33.49022,
		"lon": -70.51576,
		"sequence": 129
	},
	{
		"_id": "621baa7068878f576568a986",
		"loc": [-70.51587, -33.49013],
		"lat": -33.49013,
		"lon": -70.51587,
		"sequence": 130
	},
	{
		"_id": "621baa7068878f576568a987",
		"loc": [-70.51597000000001, -33.49006],
		"lat": -33.49006,
		"lon": -70.51597000000001,
		"sequence": 131
	},
	{
		"_id": "621baa7068878f576568a988",
		"loc": [-70.51604, -33.490030000000004],
		"lat": -33.490030000000004,
		"lon": -70.51604,
		"sequence": 132
	},
	{
		"_id": "621baa7068878f576568a989",
		"loc": [-70.51604, -33.490030000000004],
		"lat": -33.490030000000004,
		"lon": -70.51604,
		"sequence": 133
	},
	{
		"_id": "621baa7068878f576568a98a",
		"loc": [-70.51604, -33.490010000000005],
		"lat": -33.490010000000005,
		"lon": -70.51604,
		"sequence": 134
	},
	{
		"_id": "621baa7068878f576568a98b",
		"loc": [-70.51605, -33.49],
		"lat": -33.49,
		"lon": -70.51605,
		"sequence": 135
	},
	{
		"_id": "621baa7068878f576568a98c",
		"loc": [-70.51607, -33.48962],
		"lat": -33.48962,
		"lon": -70.51607,
		"sequence": 136
	},
	{
		"_id": "621baa7068878f576568a98d",
		"loc": [-70.51608, -33.48946],
		"lat": -33.48946,
		"lon": -70.51608,
		"sequence": 137
	},
	{
		"_id": "621baa7068878f576568a98e",
		"loc": [-70.51610000000001, -33.48924],
		"lat": -33.48924,
		"lon": -70.51610000000001,
		"sequence": 138
	},
	{
		"_id": "621baa7068878f576568a98f",
		"loc": [-70.51614000000001, -33.489050000000006],
		"lat": -33.489050000000006,
		"lon": -70.51614000000001,
		"sequence": 139
	},
	{
		"_id": "621baa7068878f576568a990",
		"loc": [-70.51614000000001, -33.489050000000006],
		"lat": -33.489050000000006,
		"lon": -70.51614000000001,
		"sequence": 140
	},
	{
		"_id": "621baa7068878f576568a991",
		"loc": [-70.51619000000001, -33.48901],
		"lat": -33.48901,
		"lon": -70.51619000000001,
		"sequence": 141
	},
	{
		"_id": "621baa7068878f576568a992",
		"loc": [-70.51624000000001, -33.48901],
		"lat": -33.48901,
		"lon": -70.51624000000001,
		"sequence": 142
	},
	{
		"_id": "621baa7068878f576568a993",
		"loc": [-70.51629000000001, -33.489050000000006],
		"lat": -33.489050000000006,
		"lon": -70.51629000000001,
		"sequence": 143
	},
	{
		"_id": "621baa7068878f576568a994",
		"loc": [-70.5163, -33.489070000000005],
		"lat": -33.489070000000005,
		"lon": -70.5163,
		"sequence": 144
	},
	{
		"_id": "621baa7068878f576568a995",
		"loc": [-70.51671, -33.48901],
		"lat": -33.48901,
		"lon": -70.51671,
		"sequence": 145
	},
	{
		"_id": "621baa7068878f576568a996",
		"loc": [-70.51679, -33.48901],
		"lat": -33.48901,
		"lon": -70.51679,
		"sequence": 146
	},
	{
		"_id": "621baa7068878f576568a997",
		"loc": [-70.51700000000001, -33.489070000000005],
		"lat": -33.489070000000005,
		"lon": -70.51700000000001,
		"sequence": 147
	},
	{
		"_id": "621baa7068878f576568a998",
		"loc": [-70.5172, -33.48913],
		"lat": -33.48913,
		"lon": -70.5172,
		"sequence": 148
	},
	{
		"_id": "621baa7068878f576568a999",
		"loc": [-70.51738, -33.48917],
		"lat": -33.48917,
		"lon": -70.51738,
		"sequence": 149
	},
	{
		"_id": "621baa7068878f576568a99a",
		"loc": [-70.51747, -33.489200000000004],
		"lat": -33.489200000000004,
		"lon": -70.51747,
		"sequence": 150
	},
	{
		"_id": "621baa7068878f576568a99b",
		"loc": [-70.51765, -33.48924],
		"lat": -33.48924,
		"lon": -70.51765,
		"sequence": 151
	},
	{
		"_id": "621baa7068878f576568a99c",
		"loc": [-70.51779, -33.48924],
		"lat": -33.48924,
		"lon": -70.51779,
		"sequence": 152
	},
	{
		"_id": "621baa7068878f576568a99d",
		"loc": [-70.51791, -33.48921],
		"lat": -33.48921,
		"lon": -70.51791,
		"sequence": 153
	},
	{
		"_id": "621baa7068878f576568a99e",
		"loc": [-70.51806, -33.489160000000005],
		"lat": -33.489160000000005,
		"lon": -70.51806,
		"sequence": 154
	},
	{
		"_id": "621baa7068878f576568a99f",
		"loc": [-70.51823, -33.48912],
		"lat": -33.48912,
		"lon": -70.51823,
		"sequence": 155
	},
	{
		"_id": "621baa7068878f576568a9a0",
		"loc": [-70.51830000000001, -33.489110000000004],
		"lat": -33.489110000000004,
		"lon": -70.51830000000001,
		"sequence": 156
	},
	{
		"_id": "621baa7068878f576568a9a1",
		"loc": [-70.51867, -33.489140000000006],
		"lat": -33.489140000000006,
		"lon": -70.51867,
		"sequence": 157
	},
	{
		"_id": "621baa7068878f576568a9a2",
		"loc": [-70.51867, -33.489140000000006],
		"lat": -33.489140000000006,
		"lon": -70.51867,
		"sequence": 158
	},
	{
		"_id": "621baa7068878f576568a9a3",
		"loc": [-70.51874000000001, -33.48897],
		"lat": -33.48897,
		"lon": -70.51874000000001,
		"sequence": 159
	},
	{
		"_id": "621baa7068878f576568a9a4",
		"loc": [-70.51881, -33.48886],
		"lat": -33.48886,
		"lon": -70.51881,
		"sequence": 160
	},
	{
		"_id": "621baa7068878f576568a9a5",
		"loc": [-70.51885, -33.488800000000005],
		"lat": -33.488800000000005,
		"lon": -70.51885,
		"sequence": 161
	},
	{
		"_id": "621baa7068878f576568a9a6",
		"loc": [-70.51892000000001, -33.488730000000004],
		"lat": -33.488730000000004,
		"lon": -70.51892000000001,
		"sequence": 162
	},
	{
		"_id": "621baa7068878f576568a9a7",
		"loc": [-70.51905000000001, -33.488580000000006],
		"lat": -33.488580000000006,
		"lon": -70.51905000000001,
		"sequence": 163
	},
	{
		"_id": "621baa7068878f576568a9a8",
		"loc": [-70.51916, -33.488400000000006],
		"lat": -33.488400000000006,
		"lon": -70.51916,
		"sequence": 164
	},
	{
		"_id": "621baa7068878f576568a9a9",
		"loc": [-70.51929000000001, -33.488040000000005],
		"lat": -33.488040000000005,
		"lon": -70.51929000000001,
		"sequence": 165
	},
	{
		"_id": "621baa7068878f576568a9aa",
		"loc": [-70.51929000000001, -33.48798],
		"lat": -33.48798,
		"lon": -70.51929000000001,
		"sequence": 166
	},
	{
		"_id": "621baa7068878f576568a9ab",
		"loc": [-70.51928000000001, -33.48792],
		"lat": -33.48792,
		"lon": -70.51928000000001,
		"sequence": 167
	},
	{
		"_id": "621baa7068878f576568a9ac",
		"loc": [-70.51897000000001, -33.48729],
		"lat": -33.48729,
		"lon": -70.51897000000001,
		"sequence": 168
	},
	{
		"_id": "621baa7068878f576568a9ad",
		"loc": [-70.51859, -33.48666],
		"lat": -33.48666,
		"lon": -70.51859,
		"sequence": 169
	},
	{
		"_id": "621baa7068878f576568a9ae",
		"loc": [-70.5185, -33.486520000000006],
		"lat": -33.486520000000006,
		"lon": -70.5185,
		"sequence": 170
	},
	{
		"_id": "621baa7068878f576568a9af",
		"loc": [-70.5185, -33.486520000000006],
		"lat": -33.486520000000006,
		"lon": -70.5185,
		"sequence": 171
	},
	{
		"_id": "621baa7068878f576568a9b0",
		"loc": [-70.51862000000001, -33.486520000000006],
		"lat": -33.486520000000006,
		"lon": -70.51862000000001,
		"sequence": 172
	},
	{
		"_id": "621baa7068878f576568a9b1",
		"loc": [-70.51864, -33.48646],
		"lat": -33.48646,
		"lon": -70.51864,
		"sequence": 173
	},
	{
		"_id": "621baa7068878f576568a9b2",
		"loc": [-70.51867, -33.48631],
		"lat": -33.48631,
		"lon": -70.51867,
		"sequence": 174
	},
	{
		"_id": "621baa7068878f576568a9b3",
		"loc": [-70.51867, -33.48631],
		"lat": -33.48631,
		"lon": -70.51867,
		"sequence": 175
	},
	{
		"_id": "621baa7068878f576568a9b4",
		"loc": [-70.51873, -33.48633],
		"lat": -33.48633,
		"lon": -70.51873,
		"sequence": 176
	},
	{
		"_id": "621baa7068878f576568a9b5",
		"loc": [-70.51877, -33.486360000000005],
		"lat": -33.486360000000005,
		"lon": -70.51877,
		"sequence": 177
	},
	{
		"_id": "621baa7068878f576568a9b6",
		"loc": [-70.51878, -33.486380000000004],
		"lat": -33.486380000000004,
		"lon": -70.51878,
		"sequence": 178
	}
]

'''

# Ruta del archivo de texto donde se almacenarán las latitudes y longitudes
ruta_txt = 'lat_lon_final.txt'

# Función para extraer latitudes y longitudes y escribir en el archivo de texto
def extraer_lat_lon(json_data, ruta_txt):
    data = json.loads(json_data)
        
    with open(ruta_txt, 'w') as f:
        for item in data:  
            lat = item['lat']
            lon = item['lon']
            f.write(f'  Set Location    {lat}     {lon}\n')
            f.write(f'  Sleep    3s\n')

# Llamar a la función para extraer y escribir los datos
extraer_lat_lon(json_data, ruta_txt)