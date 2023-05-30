# Monthly Expenses Calculator
# By : Shaikh Ibrahim Noman

library(shiny)

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Monthly Expenses Calculator"),
  
  # Sidebar with inputs for expenses
  sidebarLayout(
    sidebarPanel(
      selectInput("select", h3("Select Month"), 
                  choices = list("January" = 1, "February" = 2,
                                 "March" = 3, "April" = 4, "May" = 5,
                                 "June" = 6, "July" = 7, "August" = 8,
                                 "September" = 9, "October" = 10, "November" = 11,
                                 "December" = 12), selected = 1),
      numericInput("rent", "Rent", value = 800),
      numericInput("groceries", "Groceries", value = 300),
      numericInput("transportation", "Transportation", value = 100),
      numericInput("miscellaneous", "Miscellaneous", value = 50),
      actionButton("calculate", "Calculate")
    ),
    
    # Display the total monthly expenses and bar plot
    mainPanel(
      h4("Total Monthly Expenses:"),
      verbatimTextOutput("totalExpenses"),
      plotOutput("expensesPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Calculate and display total monthly expenses
  observeEvent(input$calculate, {
    total <- input$rent + input$groceries + input$transportation + input$miscellaneous
    output$totalExpenses <- renderText(paste("$", total))
  })
  
  # Create and display the bar plot
  output$expensesPlot <- renderPlot({
    expenses <- c(input$rent, input$groceries, input$transportation, input$miscellaneous)
    categories <- c("Rent", "Groceries", "Transportation", "Miscellaneous")
    barplot(expenses, names.arg = categories, xlab = "Categories", ylab = "Amount", col = "lightblue", main = "Monthly Expenses Distribution")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
