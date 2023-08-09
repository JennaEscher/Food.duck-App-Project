import pandas as pd
import numpy as np
import argparse
parser = argparse.ArgumentParser(description="A simple program that converts xlsx files to json files.",
                                 epilog = '''
    # MODE 0 : opentime, closetime, breaktime are seperate values.
        [OPENTIME],[CLOSETIME],[BREAKSTART-BREAKEND]

    # MODE 1 : opentime, closetime, breaktime are in a list.
        [OPENTIME,CLOSETIME,BREAKSTART-BREAKEND]

    # MODE 2 : opentime, closetime, breaktime are in a list.
        [OPENTIME,CLOSETIME,[BREAKSTART,BREAKEND]]

    # MODE 3 : opentime, closetime, breaktime are in a list, breaktime is broken into two parts.
        [OPENTIME,CLOSETIME,BREAKSTART,BREAKEND]                                             
    ''',
                                 formatter_class=argparse.RawTextHelpFormatter)

NO_OF_TAGS = 20
VERSION = 1.2

# ==========] INPUT FLAGS [========== #

pd.set_option('display.max_rows', 5)

parser.add_argument("-m", "--mode", help = "Parse mode", type = int,choices=range(0, 4), default= 3)
parser.add_argument("-f", "--filename", help="Input File name. File format must be '.xlsx' format.\nDefault: 'food_jason.xlsx'", type=str, default= 'food_jason.xlsx')
parser.add_argument("-s", "--sheetname", help="Sheet name which contains the data.\nDefault: 'Sheet1'", type=str, default= 'Sheet1')
parser.add_argument("-o", "--output", help="Output File name. \nDefault:'Output.json'", type=str, default= 'Output.json')
parser.add_argument("-dm", "--dropmode", help = "Duplicate Drop mode. In case of duplicates, dm 0 keeps the first instance, and 1 keeps the last instance.\nDefault : 0", type = int,choices=range(0, 2), default= 0)
parser.add_argument('--verbose', '-v', action='count', default=0)
parser.add_argument('--replace-null', action='store_true')
parser.add_argument('--replace-null-custom', action='store')

parser.add_argument('--version', action='version', version=f'%(prog)s V {VERSION}')

args = parser.parse_args()

extension = ".xlsx"
if extension in args.filename:
    pass
else:
    args.filename = args.filename + '.xlsx'

extension = ".json"
if extension in args.output:
    pass
else:
    args.output = args.output + '.json'

# If Vewwy Vewwy Verbose, disable row, column truncation
if args.verbose == 3:
    pd.set_option('display.max_rows', None)
    pd.set_option('display.max_columns', None)


# ==========] MAIN [========== #

if args.verbose >= 1:
    print("")
    print(f'Version: {VERSION}\n')
    
    print(f'Input: "{args.filename}"')
    print(f'Output: "{args.output}"')
    print(f'Parse Mode: {args.mode}')
    if args.replace_null == True or args.replace_null_custom != None:
        print('Replace null values: Yes')
        if args.replace_null_custom != None:
            print(f'  ㄴNaN will be replaced as: {args.replace_null_custom}')
        else:
            print(f'  ㄴNaN will be replaced as empty string')
    else:
        print('Replace null values: No')
    if args.dropmode == 0:
        print('Program will keep first instance of duplicates')
    elif args.dropmode == 1:
        print('Program will keep last instance of duplicates')
    print(f'Verbosity: {args.verbose}')
    print("\nStarting Program...\n")
    print("Opening Excel File...")


excel_raw = pd.read_excel(args.filename, sheet_name=args.sheetname, usecols=['name', 'address', 'category','trav_time','opendays','image','MapLink','OneLiner'])
excel_raw['category'] = excel_raw['category'].str.replace(" ","")
#excel_raw['trav_time'] = excel_raw['trav_time'].str.replace(" ","")
#excel_raw['opendays'] = excel_raw['opendays'].str.replace(" ","")

if excel_raw['name'].duplicated().any() == True:
    print("⚠️ WARNING ⚠️\nDuplicate names detected! \nDropping duplicates....")
    if args.dropmode == 0:
        excel_raw.drop_duplicates(subset=['name'],keep = 'first',inplace = True)
        print("Dropped Duplicates. First instance kept. Use '-dm 1' to keep last." )
    else:
        excel_raw.drop_duplicates(subset=['name'],keep = 'last',inplace = True)
        print("Dropped Duplicates. Last instance kept. Use '-dm 0' to keep first." )
    
excel_raw = excel_raw.sort_values(by = ['name'])
excel_raw = excel_raw.reset_index(drop = True)

# ========== [create sub-lists] ========== #

# ----------[ Tag Lists ] ----------#
if args.verbose >= 1:
    print("Parsing Tags...")

usetagcolswname = ['name']
usetagcols = []

for i in range(NO_OF_TAGS):
    i = i +1
    tagstr = 'tag' + str(i)
    usetagcolswname.append(tagstr)
    usetagcols.append(tagstr)

TagList= pd.read_excel(args.filename, sheet_name=args.sheetname, usecols=usetagcolswname)
TagList['tag1'] = TagList['tag1'].str.replace(" ","")
TagList['tags'] = TagList[usetagcols].values.tolist()
TagList.drop(columns=usetagcols,inplace = True)

FinalList = excel_raw.merge(TagList,on='name')

if args.verbose >= 2:
    print(TagList)

del usetagcolswname
del usetagcols

# ---------- [ Open/Close/Break Times ] ---------- #
if args.verbose >= 1:
    print("Parsing Times...")

OpenTimeList = pd.read_excel(args.filename, sheet_name=args.sheetname, usecols=['name','opentime'])
OpenTimeList['opentime'] = OpenTimeList['opentime'].str.replace(" ","")

CloseTimeList = pd.read_excel(args.filename, sheet_name=args.sheetname, usecols=['name','closetime'])
CloseTimeList['closetime'] = CloseTimeList['closetime'].str.replace(" ","")

BreakTimeList = pd.read_excel(args.filename, sheet_name=args.sheetname, usecols=['name','breaktime'])
BreakTimeList['breaktime'] = BreakTimeList['breaktime'].str.replace(" ","")


# MODE 0 : opentime, closetime, breaktime are seperate values => [OPENTIME],[CLOSETIME],[BREAKSTART-BREAKEND]
# MODE 1 : opentime, closetime, breaktime are in a list => [OPENTIME,CLOSETIME,BREAKSTART-BREAKEND]
# MODE 2 : opentime, closetime, breaktime are in a list => [OPENTIME,CLOSETIME,[BREAKSTART,BREAKEND]]
# MODE 3 : opentime, closetime, breaktime are in a list, breaktime is broken into two parts: breaktimeStart, breaktimeEnd => [OPENTIME,CLOSETIME,BREAKSTART,BREAKEND] 

# ----- MODE 0 ----- #
if args.mode == 0:
    OpenTimeList = OpenTimeList.groupby("name").agg(list)
    CloseTimeList = CloseTimeList.groupby("name").agg(list)
    BreakTimeList = BreakTimeList.groupby("name").agg(list)
    FinalList = FinalList.merge(OpenTimeList,on='name')
    FinalList = FinalList.merge(CloseTimeList,on='name')
    FinalList = FinalList.merge(BreakTimeList,on='name')

    ColOrder = ["name", "address", "category", "tags", "opentime","closetime","breaktime","MapLink", "OneLiner"]
    FinalList = FinalList[ColOrder]
    
    if args.verbose >= 2:
        print("OpenTimeList: ")
        print(OpenTimeList)
        print("CloseTimeList: ")
        print(CloseTimeList)
        print("BreakTimeList: ")
        print(BreakTimeList)

# ----- MODE 1 ----- #
elif args.mode == 1:
    TimeList = OpenTimeList.merge(CloseTimeList, on='name')
    TimeList = TimeList.merge(BreakTimeList, on='name') 
    TimeList['times'] = TimeList[['opentime','closetime','breaktime']].values.tolist()
    FinalList = FinalList.merge(TimeList,on='name')

    ColOrder = ["name", "address", "category", "tags", "times","MapLink", "OneLiner"]
    FinalList = FinalList[ColOrder]
    
    if args.verbose >= 2:
        print("TimeList: ")
        print(TimeList)

# ----- MODE 2 ----- #
elif args.mode == 2:
    TimeList = OpenTimeList.merge(CloseTimeList, on='name')
    TimeList['breaktime']= BreakTimeList['breaktime'].str.split(pat = '-')
    TimeList['times'] = TimeList[['opentime','closetime','breaktime']].values.tolist() 
    TimeList.drop(columns=['opentime','closetime','breaktime'],inplace = True)
    FinalList = FinalList.merge(TimeList,on='name')
   
    ColOrder = ["name", "address", "category", "tags", "times","MapLink", "OneLiner"]
    FinalList = FinalList[ColOrder]

    if args.verbose >= 2:
        print("TimeList: ")
        print(TimeList)

# ----- MODE 3 ----- #
elif args.mode == 3:
    TimeList = OpenTimeList.merge(CloseTimeList, on='name')

    out = BreakTimeList.join(BreakTimeList['breaktime'].str.split('-',expand=True))
    out.drop(columns=['breaktime'], inplace=True)
    out.rename(columns={0: "breaktime_start", 1: "breaktime_end"}, inplace=True)
    TimeList = TimeList.merge(out, on='name') 
    TimeList['times'] = TimeList[['opentime','closetime','breaktime_start','breaktime_end']].values.tolist()
    TimeList.drop(columns=['opentime','closetime','breaktime_start','breaktime_end'],inplace = True)
    FinalList = FinalList.merge(TimeList,on='name')

    ColOrder = ["name", "address", "category", "tags", "times","MapLink", "OneLiner"]
    FinalList = FinalList[ColOrder]

    if args.verbose >= 2:
        print("TimeList: ")
        print(TimeList)


if args.replace_null == True and args.replace_null_custom == None:
    if args.verbose >= 1:
        print("Replacing null values...")
    for i in range(len(FinalList)):
        for j in range(len(FinalList['tags'][i])):
            if type(FinalList['tags'][i][j]) == float:
                if np.isnan(FinalList['tags'][i][j]):
                    FinalList['tags'][i][j] = ''
        if args.mode == 0:
            if type(FinalList['breaktime'][i][0]) == float:
                if np.isnan(FinalList['breaktime'][i][0]):
                    FinalList['breaktime'][i][0] = ''
            print(FinalList['breaktime'][i][0])
        else:
            for j in range(len(FinalList['times'][i])):
                if type(FinalList['times'][i][j]) == float:
                    if np.isnan(FinalList['times'][i][j]):
                        if args.mode == 2:
                            FinalList['times'][i][j] = []
                        else:
                            FinalList['times'][i][j] = ''

elif args.replace_null_custom != None:
    if args.verbose >= 1:
        print("Replacing null values...")

    for i in range(len(FinalList)):
        for j in range(len(FinalList['tags'][i])):
            if type(FinalList['tags'][i][j]) == float:
                if np.isnan(FinalList['tags'][i][j]):
                    FinalList['tags'][i][j] = args.replace_null_custom
        if args.mode == 0:
            if type(FinalList['breaktime'][i][0]) == float:
                if np.isnan(FinalList['breaktime'][i][0]):
                    FinalList['breaktime'][i][0] = args.replace_null_custom
            print(FinalList['breaktime'][i][0])
        else:
            for j in range(len(FinalList['times'][i])):
                if type(FinalList['times'][i][j]) == float:
                    if np.isnan(FinalList['times'][i][j]):
                        if args.mode == 2:
                            FinalList['times'][i][j] = [args.replace_null_custom]
                        else:
                            FinalList['times'][i][j] = args.replace_null_custom

if args.verbose >= 2:
    print("\nFinal List:")
    print(FinalList)



# ==========] WRITE TO JSON [========== #
if args.verbose >= 1:
    print("Exporting to JSON....\n")
FinalList.to_json(path_or_buf = args.output, force_ascii = False, orient = 'records', indent = 2)

print("Done!")
print(f"File saved to 「{args.output} 」")