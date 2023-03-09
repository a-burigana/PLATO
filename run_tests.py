import sys, os, subprocess, time

# RUN TESTS AS FOLLOWS:
#  >> find exp -name "*instance*.lp" > tests/instances.txt
#  >> parallel -k --lb --jobs <n> python run_tests.py < tests/domains.txt

def main(argv):
    sleep_time = 10

    instance = argv[0]
    dir      = os.path.dirname(instance)
    test_dir = 'out' + os.sep + 'tests' + os.sep + dir
    csv_file = test_dir + os.sep + 'results.csv'

    if (not os.path.exists(test_dir)):
        os.makedirs(test_dir, exist_ok=True)

    output_file = open(csv_file, 'a')

    inst_name = os.path.splitext(os.path.basename(instance))[0]

    print(inst_name, end = ',', file = output_file)
    print('\n#################### RUNNING INSTANCE ' + instance + ' ####################\n')

    test_instance(instance, 'delphic', ',', output_file)
    time.sleep(sleep_time)
    
    test_instance(instance, 'kripke', '\n', output_file)
    time.sleep(sleep_time)

    output_file.close()

def test_instance(instance, semantics, end, output_file):
    start_time = time.time()
    ret = subprocess.call('python delphic.py -i ' + instance + ' -s ' + semantics + ' --test', shell=True)
    end_time = time.time()

    time_ = str(end_time-start_time) if ret == 0 else 't.o.'
    print(time_, end = end, file = output_file)
    print(semantics + ' time (exit=' + str(ret) + '): ' + str(time_) + '\n')
    
if __name__ == '__main__':
    main(sys.argv[1:])
