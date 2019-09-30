import PyInstaller.__main__

pack_name = 'py2lua'
pack_file = '%s.py' % pack_name
version_file = 'exe_version.txt'

PyInstaller.__main__.run([
    '--name=%s' % pack_name,
    '--onefile',
    '--version-file=%s' % version_file,
    pack_file
])
