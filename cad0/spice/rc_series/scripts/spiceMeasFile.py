import re

#Basic usage model
# import spiceMeasFile
# mf = spiceMeasFile.spiceMeasFile("cpm.mt0")
# mf.build_measTable()
# mf.report_failed_measurements()
# You could also just do mf.print_measTable() right after the mf= statement


class spiceMeasFile():
    def __init__(self,fileName):
        self.fileName=fileName
        self.varNames=[]
        self.measData=[]
        self.measTable={}
        self.failTable={}
        self.failedMeasurements=0

    def read_file(self):
        fh=open(self.fileName,'r')
        lines=fh.readlines()
#Now join the lines, remove \n, club spaces and build a list based on "+"
        while(re.match('(?!\.TITLE)',lines[0])):
            lines.pop(0)
        lines.pop(0) #Remove the .TITLE statement

        self.measData="".join(lines)
        self.measData=re.sub(r'[\n\s]+',' ',self.measData).strip()
        self.measData=re.split(r'\s+',self.measData)
        fh.close()

    def extract_varNames(self):
        # '''Weed out the text before the index keyword shows up'''
        # while(re.match('(?!index)', self.measData[0])):
            # self.measData.pop(0)
        # while (re.match(r'[a-z]',self.measData[0]) and (self.measData[0]!='failed')):
        while ((self.measData[0] != 'alter#') and (self.measData[0] != 'failed')):
            self.varNames.append(self.measData.pop(0))
        if (self.measData[0] == 'alter#'):
            self.varNames.append(self.measData.pop(0))

    def conv_meas_to_float(self):
        for i in range(len(self.measData)):
            if(re.match(r'[a-z]',self.measData[i])):continue
            else:self.measData[i]=float(self.measData[i])

    def classify_meas_per_varNames(self):
      '''Take the measurement data and splice it into a list based on the length of the variable array'''
      for var in self.varNames:
            self.measTable[var]=[]
            self.failTable[var]=[]
            index = self.varNames.index(var)
            self.measTable[var]=self.measData[index:len(self.measData):len(self.varNames)]


    def build_measTable(self):
#Read in the measure file
#Get the variable names
#Convert the rest of the measurements into floats
#Populate the self.measTable
        self.measData=[]
        self.measTable={}

        self.read_file()
        self.extract_varNames()
        self.conv_meas_to_float()
        self.classify_meas_per_varNames()


    def report_failed_measurements(self):
        for var in self.varNames:
            for measure in self.measTable[var]:
                if(measure=='failed'):
                    iteration=self.measTable[var].index(measure)
                    self.failTable[var].append(iteration)
                    self.failedMeasurements+=1
# print "Measurement %s failed in sweep index %d" %(var, iteration)
        if(self.failedMeasurements>0):
            print "The following measurements failed:"
            for var in self.failTable:
                if(sum(self.failTable[var])>0):
                    print "Measurement %s : Iteration" % var,
                    for index in range(len(self.failTable[var])):
                        if(self.failTable[var][index]): print self.failTable[var][index]
        else:
            print "No failed measurements"



    def print_measTable(self):
        self.build_measTable()
        for var in self.measTable:
            print "%-10s" %(var),
        print "\n"
        # print "length is %s" %(len(self.measTable['alter#']))
        for i in range(len(self.measTable['alter#'])):
            for var in self.measTable:
                print "%-10s" %(str(self.measTable[var][i])),
        print ""

    def write_measTable(self,writeFile,dataHandle):
        # dataHandle = "r'" + dataHandle + "'"
        printDict={}
        self.build_measTable()
        fileHandle=open(writeFile,'w')
        for var in sorted(self.measTable):
            printDict[var]=0
            dataVec=re.split('\s*,\s*',dataHandle)
            for pattern in dataVec:
                if(re.search(pattern,var)):
                    fileHandle.write ("%-10s " %(var))
                    printDict[var]=1
        fileHandle.write("\n")
        # print "length is %s" %(len(self.measTable['alter#']))
        for i in range(len(self.measTable['alter#'])):
            for var in sorted(self.measTable):
                if(printDict[var]):
                    fileHandle.write("%-10s " %(str(self.measTable[var][i])))
            fileHandle.write("\n")

    def print_transposeMeasTable(self):
        self.build_measTable()
        for var in self.measTable:
            print "%-10s" %(var),
            for i in range(len(self.measTable['alter#'])):
                print "%-10s" %(str(self.measTable[var][i])),
            print ""
    # print "length is %s" %(len(self.measTable['alter#']))


    def write_transposeMeasTable(self,writeFile,dataHandle):
        fileHandle=open(writeFile,'w')
        self.build_measTable()
        for var in self.measTable:
            dataVec=re.split(('\s*,\s*'),dataHandle)
            for pattern in dataVec:
                if(re.search(pattern,var)):
                    fileHandle.write("%-10s " %(var))
                    for i in range(len(self.measTable['alter#'])):
                        # print var,
                        fileHandle.write("%-10s " %(str(self.measTable[var][i])))
                    fileHandle.write("\n")



    def get_clock_skew (self,dataHandle):
        self.build_measTable()
        skewVector=[]
        dataVec=re.split(('\s*,\s*'),dataHandle)
        for index in range(len(self.measTable['alter#'])): #Search each iteration.
            maxDelay=-1.0e0
            minDelay=1.0e12
                #check validity of data
            for var in self.measTable:
                if (self.measTable[var][index] == "failed"):
                    continue
                for pattern in dataVec:
                    varValue= float(self.measTable[var][index])
                    # print "%f %f %f\n" %(self.measTable[var][index],minDelay,maxDelay)
                    # print varValue,
                    # print maxDelay,
                    # print minDelay
                    if(re.search(pattern,var)):
                        if(varValue<minDelay):
                            minDelay=varValue
                        if(varValue>maxDelay):
                            maxDelay=varValue
            skew_tuple=(minDelay, maxDelay, maxDelay-minDelay)
            skewVector.append(skew_tuple)
            # print "%e %e" %(maxDelay, minDelay)
        return skewVector



##Development
    def genContourMatrix (self,dataHandle,var0,var1,var2):
        self.build_measTable() # Get the dict of lists
        list0=self.measTable[var0]
        list1=self.measTable[var1]
        list2=self.measTable[var2]
        rows=list()
        columns=list()
        z_dict={}
        for i in range(len(self.measTable[var0])):
            #Run through the list and build the columns
            if not list0[i] in rows:
                rows.append(list0[i])
            if not list1[i] in columns:
                columns.append(list1[i])
            # print 'entering %s %s %s' %(list0[i], list1[i], list2[i])
            z_dict.setdefault(list0[i],{}).update({list1[i]: list2[i]})

        #Done with for
        rows.sort()
        columns.sort()
        return rows, columns,z_dict
