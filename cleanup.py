# import dependencies
import os
import pandas as pd
from socialreaper import Twitter
from socialreaper.tools import to_csv

os.chdir('C:\\Users\\Sebastian Pasotr\\Documents\\Data_Coding\\final_project')

def devkey():
    """
    Standard function that sets the keys given file --> 'licence.txt'
    I wrote this as a safety and convenience measure.

    Centralizing the keys allows flexibility and prevents the code from
    breaking.
    """

    keys = []
    with open('licence.txt','r') as keyfile:
        keys.append(keyfile.read())
    keys = keys[0].split('\n')

    twt = Twitter(keys[0], keys[1], keys[2], keys[3])

    return(twt)

def twtParser(handle, numTwt=500, noRply=True, inclRt=False):
    """
    This function passes:
        1. handle (has to be specified),
        2. numTwt (default = 500),
        3. noRply (default = True),
        4. inclRt (default = False).

    =======x=======

    Then, a file will be created in the same folder as the script with the
    name: handle_that_was_specified.csv

    The function will return a message confirming the latter.
    """

    tweets = devkey().user(handle, count=numTwt, exclude_replies=noRply, include_retweets=inclRt)

    metadata = list(tweets)

    fileNM = handle+'.csv'
    to_csv(metadata, filename=fileNM)
    return(fileNM + 'file created!')


def twtProcess(handle='sebasrpf', numTwt=500):
    """
    This function processes the data for a specified handle (default=sebasrpf) and numTwt (default=500).

    Within this function is another function, twtParser(). twtParser takes in the same two parameters, and creates a file with the entirety of metadata for the handle.
    """
    # mines data and creates respective .csv file
    twtParser(handle, numTwt)

    # open file
    dataFile = pd.read_csv(handle+'.csv', low_memory=False)
    # col names
    txts = 'full_text'
    favs = 'favorite_count'
    rts = 'retweet_count'
    dts = 'created_at'
    engs = 'engagement'
    prfs = 'performance'
    flls = 'user.followers_count'
    lts = 'twtlength'
    sent = 'sentiment'

    # extract specific col names as DataFrame
    dataFile = dataFile[[txts, favs, rts, dts, flls]]
    # create engagement col ==> retweets + favorites
    dataFile[engs] = dataFile[rts]+dataFile[favs]
    #created performance col
    dataFile[prfs] = round(100*(dataFile[engs]/dataFile[flls]), 2)
    # create length col
    dataFile[lts] = dataFile['full_text'].apply(lambda x: len(x))
    # change date to year only
    dataFile[dts] = dataFile[dts].apply(lambda x: x[-4:])
    # save file as handle_spdash.csv
    fileName = handle+'_spdash.csv'
    dataFile.to_csv('C:\\Users\\Sebastian Pasotr\\Documents\\Data_Coding\\final_project\\{}'.format(fileName))

    return(dataFile)


# © Sebastián Pastor Ferrari - 2019
