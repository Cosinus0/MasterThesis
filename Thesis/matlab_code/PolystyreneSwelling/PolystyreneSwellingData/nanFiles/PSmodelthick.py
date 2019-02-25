import csv
import numpy 

runninglist = []

# Initialise array

for i in range(1,471+1):
	modelthick = []

	# Open file

	my_file = open("psswellingrun2_%d.nan" %i,"r")
	
	for line in my_file:
		if "[layer2]" in line:
			break

	my_file.readline()
	a = my_file.readline()
	modelthick.append(float(a.split(";")[1]))

	# Close file

	my_file.close()

	runninglist.append(modelthick)

a = numpy.array(runninglist)
numpy.savetxt("PSmodelthick", a, delimiter =",")