#!/user/bin/python
import qi
import sys
import os


def main():
    try:
        try:
            session = qi.Session('localhost')
            dialog = session.service('ALDialog')
        except RuntimeError as e:
            raise RuntimeError("[ERROR] requires a local naoqi session...\n{}".format(e))
        try:
            result = session.service('DialogUtilities').load_lexicon()
        except RuntimeError as e:
            raise RuntimeError('Load Lexicon with DialogUtilities service failed...')
        if result:
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
            except RuntimeError:
                raise RuntimeError('Load Lexicon by path failed...')

            dlg_path = sys.argv[1]
            # print(dlg_path)
            dialog.loadTopic(dlg_path)
            print('SUCCESS')
        else:
            print('Load Lexicon with DialogUtilities returned False...')
    except RuntimeError as e:
        print(e)

if __name__ == '__main__':
    main()
