import PyInstaller.__main__

pack_name = 'py2lua'
pack_file = '%s.py' % pack_name

PyInstaller.__main__.run([
    '--name=%s' % 'py2lua',
    '--onefile',
    pack_file
])
