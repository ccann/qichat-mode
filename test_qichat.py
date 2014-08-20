#!/user/bin/python
import qi
import sys
import os


def main():
    try:
        session = qi.Session('localhost')
        dialog = session.service('ALDialog')
        try:
            session.service('DialogUtilities').load_lexicon()
        except RuntimeError:
            print('Load Lexicon with DialogUtilities service failed...')
        try:
            dialog.loadTopic(os.path.join(os.path.expanduser('~'),
                                          '.local',
                                          'share',
                                          'PackageManager',
                                          'apps',
                                          'dialog_utilities',
                                          'dialog',
                                          'Lexicon',
                                          'Lexicon.dlg'))
        except:
            print('Load Lexicon by path failed...')

        dlg_path = sys.argv[1]
        # print(dlg_path)
        dialog.loadTopic(dlg_path)
        print('SUCCESS')
    except RuntimeError:
        print("[ERROR] requires a local naoqi session...")


if __name__ == '__main__':
    main()
