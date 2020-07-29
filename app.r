library(shiny)

ui = navbarPage('TwitterDashboard',
  tabPanel('Description', 
           h4('Twitter Dashboard'),
           h5('This dashboard was created by © Sebastian Pastor Ferrari in order to track Twitter accounts
              with Key Performance Indicators (KPIs).'),
           br(),
            
           h6('** Natural Language Toolkit (© Copyright 2019, NLTK Project) 
               is integrated in order to tokenize tweets and provide sentiment scores.'),
           br(),
           h6(' © Sebastian Pastor Ferrari - 2019 - Version 0.1')),
  
  navbarMenu('Key Performance Indicators (KPIs)',
             tabPanel('General KPIs [ALL LANGUAGES]', 
                      
                      sidebarPanel(
                        selectInput("kpiSel", "KPI Selection:", 
                                    choices=list('Engagement',
                                                 'Performance',
                                                 'Tweet Length')),
                        hr(),
                        helpText("Last update: 12/16/2019 -- 8:30 PM")
                      ),
                      
                      # Create a spot for the barplot
                      mainPanel(
                        plotOutput("kpiPlot")  
                      ))
             
             # tabPanel('Sentiment KPIs [ENGLISH ONLY] - © Copyright 2019, NLTK Project', 
             #          plotOutput('sentkpi')
             #          )
             ),
  
  tabPanel('Twitter Handle',
           fileInput("file1", label = h3("Handle Selector")),
           
           hr(),
           fluidRow(column(4, verbatimTextOutput("value"))),
           
           radioButtons(inputId='checkbox1',
                              label='General KPIs [ALL LANGUAGES]',
                              choices=list('@realdonaldtrump'='realdonaldtrump_spdash.csv',
                                           '@kimkardashian'='kimkardashian_spdash.csv',
                                           '@kanyewest'='kanyewest_spdash.csv',
                                           '@cdolimpia'='cdolimpia_spdash.csv',
                                           # '@juanpa_sabillon'='juanpa_sabillon_spdash.csv',
                                           # '@vijildaniel'='vijildaniel_spdash.csv',
                                           # '@mmvilleda'='mmvilleda_spdash.csv',
                                           '@arsenal'='arsenal_spdash.csv',
                                           '@sebasrpf'='sebasrpf_spdash.csv'),
                              ), h6('© Sebastian Pastor Ferrari - 2019')
           ))


server = function(input, output) {
  output$kpiPlot = renderPlot({
    
    tryCatch({
      df = read.csv(input$checkbox1)
    })
    
    selection = str(input$kpiSel)
    
    attach(df)
    
    a = barplot(df$engagement)
    
    if(input$kpiSel == 'Engagement'){
      a = barplot(df$engagement)
    }else if(input$kpiSel == 'Performance') {
      a = plot(df$performance~df$engagement, main='Performance KPI')
    }else if(input$kpiSel == 'Tweet Length'){
      a = plot(df$twtlength, main='Tweet Length KPI')
    }
    
    
    
  })
}
shinyApp(ui=ui,server=server)

