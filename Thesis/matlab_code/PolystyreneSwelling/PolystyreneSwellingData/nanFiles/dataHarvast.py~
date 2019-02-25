import csv
import numpy 

runninglist = []

# Initialise array

for i in range(1,471+1):

	model = []

	# Open file

	my_file = open("psswellingrun2_%d.nan" %i,"r")
	for line in my_file:
		if "[data]" in line:
			break
	for line in my_file:
		model.append(float(line.split(",")[1]))

	# Close file

	my_file.close()

	runninglist.append(model)

a = numpy.array(runninglist)
numpy.savetxt("PSmodel", a, delimiter =",")
