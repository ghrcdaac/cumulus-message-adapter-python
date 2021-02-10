import shutil

import pip

pip.main(['install', '--target', './package', '-r', 'requirements.txt'])
[shutil.copy(ele, './package/') for ele in ['run_cumulus_task.py', 'cumulus_logger.py']]
shutil.make_archive('./cma_python', 'zip', './package')
shutil.rmtree('./package')
