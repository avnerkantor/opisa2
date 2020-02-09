library(shiny)
library(dplyr)
library(plotly)
library(htmltools)
library(htmlwidgets)
library(stringr)
library(DT)
library(shinyAce)

init <-'
```{r echo=FALSE}
sector<-israel2018%>%filter(Country=="Israel Hebrew")
fit<-lm(PVMATH~ESCS+PISADIFF, weights = W_FSTUWT, data=sector)
summary(fit)
```
```{r echo=FALSE, warning=FALSE}
ggplot(data=sector, aes(y=PVMATH, x=ESCS, color=PISADIFF)) +
      geom_smooth(method="lm", se=TRUE) +
      geom_point(alpha = 0.1) +
      theme_bw() 
```
'


fluidPage(
  title="פיזה פתוח",
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$script(src = "custom.js"),
    tags$link(rel = "shortcut icon", href = "img/bag-512.png")),
  
  tags$div(HTML(
    '  
<div id="myHeader">
    <div class="header-image"></div>
    <div class="text-image">פיזה פתוח</div>
     <div class="underHeaderText"></div>  
      </div>
')),
  
  
  fluidRow(
    column(8,    
           fluidRow(
             column(12, style="direction:rtl",
                    
                    tags$div(HTML('
                    <table class="dtable">
             <tr>
             <td>
                    <div id="Subject"
       class="text-center form-group shiny-input-radiogroup shiny-input-container shiny-input-container-inline">
       <div class="shiny-options-group">
        <form class="form-horizontal" method="post" action="">
            <div data-toggle="buttons">
                <div class="subjectButtons">
                    <label class="radio-inline btn btn-default btn-circle btn-lg text-center active">
                        <input type="radio" name="Subject" value="Math" checked="checked"/>
                        <span><img src="img/math.png" class="subjectImage "/></span>
                    </label>
                    <small>מתמטיקה</small>
                </div>
                <div class="subjectButtons">
                    <label class="radio-inline btn btn-default btn-circle btn-lg text-center">
                        <input type="radio" name="Subject" value="Science"/>
                        <span><img src="img/science.png" class="subjectImage"/></span>
                    </label>
                    <small>מדעים</small>
                </div>
                <div class="subjectButtons">
                    <label class="radio-inline btn btn-default btn-circle btn-lg text-center">
                        <input type="radio" name="Subject" value="Reading"/>
                        <span><img src="img/reading.png" class="subjectImage"/></span>
                    </label>
                    <small>קריאה</small>
                </div>
                </div>
            </form>
        </div>
    </div>
    </td>
    <td>
    <div id="genderDiv"">
        <small>מגדר</small>
        <div id="Gender"
        class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline">
        <div class="shiny-options-group btn-group" data-toggle="buttons">

        <label class="btn btnMeasurments" id="femaleBtn">
            <input type="checkbox" name="Gender" value="Female"/>
            <span>בנות</span>
        </label>
        <label class="btn btnMeasurments" id="maleBtn">
            <input type="checkbox" name="Gender" value="Male"/>
            <span>בנים</span>
        </label>
        
    </div>
</div>
</td>
<td>
        <div id="escsDiv">
    <small>מצב כלכלי</small>
    <div id="Escs"
    class="form-group shiny-input-checkboxgroup shiny-input-container shiny-input-container-inline">
    <div class="shiny-options-group btn-group" data-toggle="buttons">
        <label class="btn btnMeasurments" id="lowBtn">
            <input type="checkbox" name="Escs" value="Low"/>
            <span>נמוך</span>
        </label>

        <label class="btn btnMeasurments" id="mediumBtn">
            <input type="checkbox" name="Escs" value="Medium"/>
            <span>בינוני</span>
        </label>
        <label class="btn btnMeasurments" id="highBtn">
            <input type="checkbox" name="Escs" value="High"/>
            <span>גבוה</span>
        </label>
    </div>
</div>
</div>
                                  </td>
                                  </tr>
                                  </table>
                                  '))
                    
                    # column(4, radioButtons("Subject", "", c("Math", "Science", "Reading"), inline = T)),
                    # column(4,checkboxGroupInput("Gender", "", c("Female", "Male"), inline = T)),
                    # column(4, checkboxGroupInput("Escs", "", c("Low", "Medium", "High"), selected=c("Low", "High"), inline = T)),
             ),
             column(6, 
                    selectInput("Country1", label="", choices="ישראל", selected = "ישראל"),
                    plotlyOutput("Country1Plot", height = 300)
             ),
             column(6, 
                    selectInput("Country2", label="", choices="הולנד", selected = "הולנד"),
                    plotlyOutput("Country2Plot", height = 300)
             )
             # column(12,      
             # column(2,numericInput("LevelNumber", "", value=3, step=1)),
             # column(10, tableOutput('ExplenationTable')))
           )
    ), 
    column(4, class="columnText",
           p("מערכת החינוך פועלת להקנות מיומנויות חשיבה והבנה לקראת חייהם הבוגרים של התלמידים.
"),
           p("מחקר פיזה בוחן הצלחת מערכות חינוך במשימה זו. מדי שלוש שנים עורך ה-OECD (הארגון לשיתוף פעולה ולפיתוח כלכלי) בחינה הכוללת כחצי מיליון תלמידים ברחבי העולם. ההישגים הלימודים מלמדים על מוכנותם להשתלב ולתרום לחברה.
"),
           p("מחקר פיזה כולל שאלונים אודות הרקע של התלמידים, הסביבה החינוכית ועמדותיהם ותפיסותיהם לגבי הלימודים. גם מנהלי בתי הספר נשאלים אודות מדיניות בית הספר, האקלים הבית-ספרי, כמות השעות הנלמדת ועוד.
"),
           p("תוצאות המחקר משקפות פערים לימודיים הנובעים ממגדר, מצב כלכלי ומקום מגורים. אולם ניתוח הנתונים והשוואה בין מדינות מראה אלו גורמים בסביבה החינוכית יכולים לסייע בצמצום הפערים.
")
    )
  ),
  #   hr(),
  #   fluidRow(
  #     column(8,  DT::dataTableOutput("surveyTable"),
  #            checkboxGroupInput("show_survey_vars", "", "", inline=TRUE, width='800px')
  #     ),
  #     column(4, class="columnText",
  #            p("מחקר פיזה כולל שאלונים אודות הרקע של התלמידים, הסביבה החינוכית ועמדותיהם ותפיסותיהם לגבי נושאי הלימוד. גם מנהלי בתי הספר נשאלים אודות מדיניות בית הספר, האקלים הבית-ספרי, כמות השעות הנלמדת ועוד.
  # "),
  #            p("ננתח את השאלונים ונבחן האם המצב הכלכלי או מגדר יכולים להסביר תשובות. 
  # "),
  #            p("ננתח את השאלונים ונבחן האם המצב הכלכלי או מגדר יכולים להסביר תשובות. 
  # "),
  #            p("בטבלה שאלות השאלון נמצאות ב-variable. המשתנים המסבירים - מצב כלכלי (ESCS) ומגדר (Gender) - נמצאים ב-subject. 
  # "),
  #            p("r squared משמעו עד כמה המצב הכלכלי או המגדר יכולים להסביר שונות בתשובות התלמידים. אפס משמעו כי אינם מסבירים. "),
  #            p("p.value משמעו האם הנתונים מובהקים סטטיסטית. נסתפק בערך נמוך מ-0.05. 
  # "),
  #            p("t.value משמעו גודל ההבדל בין הנתונים. 
  # "),
  #            p("n הוא מספר הפריטים בתת המדגם.
  # ")
  #     )),
  hr(),
  fluidRow(
    column(8, DT::dataTableOutput("analyzeTable"),
           checkboxGroupInput("show_vars", "", "", inline=TRUE, width='800px')
    ),
    column(4,class="columnText",
           p("בטבלה מוצגים מדדים אשר הוכנו על בסיס השאלונים. במחקר נבדק האם יש להם קשר להישגי התלמידים. קשרים אלו יכולים להסביר את הישגי התלמידים בתחומים שונים. הם יכולים ללמד על מדדים שנראים חשובים אך בפועל אינם קשורים. המחקר מאפשר להשוות וללמוד מניסיונן של מדינות שונות.
"),
           p("בטבלה המדד -variable - הוא המשתנה המסביר. תחום האוריינות - subject - הוא המשתנה המוסבר.
"),
           p("r squared משמעו עד כמה המצב הכלכלי או המגדר יכולים להסביר שונות בתשובות התלמידים. אפס משמעו כי אינם מסבירים. "),
           p("r squared משמעו עד כמה המשתנה יכולים להסביר שונות בתשובות התלמידים. אפס משמעו כי אינם מסבירים. 
"),
           p("p.value משמעו האם הנתונים מובהקים סטטיסטית. נסתפק בערך נמוך מ-0.05. 
"),
           p("t.value משמעו גודל ההבדל בין הנתונים.
           "),
           p("n הוא מספר הפריטים בתת המדגם.
           "),
           p("נשמח אם תוסיפו ממצאים בלוח הנמצא בתחתית העמוד. ניתן גם להוריד את הנתונים או לנתח עצמאית. זכרו כי מציאת קשר אינה מלמדת בהכרח על סיבתיות. 
")
    )
  ),
  hr(),
  fluidRow(
    column(
      6,
      h4("Source Code"),
      aceEditor("rmd", mode = "markdown", height = "200px",
                autoScrollEditorIntoView = TRUE,
                autoComplete = "live",
                autoCompleters  = c("text","static", "rlang"),
                value = init),
      actionButton("eval", "Evaluate")
      
      # br(),
      
      # downloadButton('downloadData', 'Download')
    ),
    column(
      6,
      h4("Output"),
      htmlOutput("knitDoc")
      # verbatimTextOutput("output")
    )
  ),
  hr(),
  fluidRow(
    column(8,
           tags$div(HTML('
           <div style="direction: rtl">
             <a  href="http://infosoc.haifa.ac.il/index.php/en/"><img id="IC_logo" src="img/IC_logo.png" ></a>
             <a  href="http://www.trump.org.il/"><img id="TrumpLogo" src="img/Trump-logo.png"></a>
                        <a href="https://www.allcloud.io/"><img id="AllCloudLogo" src="img/AllCloud.png"></a>
             </div>
           '))
    ),
    column(4, style="direction: rtl;",
           tags$b("צוות הפרוייקט"),
           br(),
           "ניהול: ", a(href="http://gsb.haifa.ac.il/~sheizaf/", "פרופ' שיזף רפאלי"),
           br(),
           'ריכוז: ד"ר עדי ליבסקר', 
           br(),
           "מחקר ופיתוח: ", a(href="http://avnerkantor.com/", "אבנר קנטור"),
           br(),
           "הדמיית נתונים: ", a(href="http://infoserviz.co.il/", "InfoserViz")
           # br(),
           # br(),
           # a(href="https://github.com/avnerkantor/opisa2", "לקוד הפרויקט")
    )
  ),
  br(),
  fluidRow(
    tags$div(HTML('<div class="padlet-embed" style="border:1px solid rgba(0,0,0,0.1);border-radius:2px;box-sizing:border-box;overflow:hidden;position:relative;width:100%;background:#F4F4F4"><p style="padding:0;margin:0"><iframe src="https://padlet.com/embed/kbsx225mwpz7" frameborder="0" style="width:100%;height:608px;display:block;padding:0;margin:0"></iframe></p></div>'))
  )
)




