setwd('~/Data_Coding/final_project')
help(barplot)
# option a: Parse file in R
sebasData = read.csv('sebas2.csv', encoding='UTF-8')
plot(sebasData$engagement~sebasData$created_at)



fullText = sebasData$full_text
retweetCount = sebasData$retweet_count
favoriteCount = sebasData$favorite_count
date = sebasData$created_at
engagement = c(sebasData$retweet_count + sebasData$favorite_count)

df = data.frame(fullText, retweetCount, favoriteCount, engagement, date)

df  

# option b: Open the file parsed in cleanup.py
new = read.csv('sebas.csv', encoding='UTF-8')
attach(new)
fullText = full_text
retweetCount = retweet_count
favoriteCount = favorite_count
date = created_at
engagement = engagement

df = data.frame(fullText, retweetCount, favoriteCount, engagement, date)





# 
# checkboxGroupInput(inputId='checkbox3',
#                   label='[Tweets in Spanglish]',
#                   choices=c('@sebasrpf','@rpastorferrari','@usembassyhn'))