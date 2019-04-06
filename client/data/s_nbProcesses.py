import psutil

processes=psutil.pids()
print(len(processes))
