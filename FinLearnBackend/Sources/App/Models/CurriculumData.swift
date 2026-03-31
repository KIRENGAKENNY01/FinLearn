import Foundation

struct CurriculumData {
    
    // MARK: - Stages
    static let stages: [(id: String, title: String, order: Int)] = [
        ("beginner", "Beginner", 1),
        ("intermediate", "Intermediate", 2),
        ("advanced", "Advanced", 3)
    ]
    
    // MARK: - Chapters
    static let chapters: [(id: String, stageId: String, title: String, order: Int)] = [
        ("b_ch1", "beginner", "Why Financial Literacy Matters in Everyday Life", 1),
        ("b_ch2", "beginner", "What Is Saving?", 2),
        ("b_ch3", "beginner", "Understanding Bank Accounts", 3),
        ("b_ch4", "beginner", "Budgeting Basics", 4),
        ("b_ch5", "beginner", "Needs vs Wants", 5),
        
        // Intermediate
        ("i_ch1", "intermediate", "Understanding Credit & Loans", 1),
        ("i_ch2", "intermediate", "Building a Credit Score", 2),
        ("i_ch3", "intermediate", "Debt Repayment Strategies", 3),
        ("i_ch4", "intermediate", "Financial Planning & Goals", 4),
        ("i_ch5", "intermediate", "Income Growth & Side Hustles", 5),
        
        // Advanced
        ("a_ch1", "advanced", "Investing Fundamentals", 1),
        ("a_ch2", "advanced", "Diversification & Risk", 2),
        ("a_ch3", "advanced", "Retirement Planning", 3),
        ("a_ch4", "advanced", "Wealth Building Strategies", 4),
        ("a_ch5", "advanced", "Financial Independence & Legacy", 5)
    ]
    
    // MARK: - Topics
    static let topics: [(id: String, chapterId: String, title: String, order: Int)] = [
        ("b_ch1_t1", "b_ch1", "Understanding Financial Literacy", 1),
        ("b_ch1_t2", "b_ch1", "Why Money Knowledge Is Important", 2),
        ("b_ch1_t3", "b_ch1", "Improving Financial Awareness", 3),

        ("b_ch2_t1", "b_ch2", "Understanding Saving", 1),
        ("b_ch2_t2", "b_ch2", "Types of Savings", 2),
        ("b_ch2_t3", "b_ch2", "Building a Saving Habit", 3),

        ("b_ch3_t1", "b_ch3", "What Is a Bank?", 1),
        ("b_ch3_t2", "b_ch3", "Types of Bank Accounts", 2),
        ("b_ch3_t3", "b_ch3", "Using Bank Accounts Safely", 3),

        ("b_ch4_t1", "b_ch4", "What Is a Budget?", 1),
        ("b_ch4_t2", "b_ch4", "Creating a Simple Budget", 2),
        ("b_ch4_t3", "b_ch4", "Sticking to a Budget", 3),

        ("b_ch5_t1", "b_ch5", "Understanding Needs", 1),
        ("b_ch5_t2", "b_ch5", "Understanding Wants", 2),
        ("b_ch5_t3", "b_ch5", "Making Smart Choices", 3),
        
        // Intermediate
        ("i_ch1_t1", "i_ch1", "What Is Credit?", 1),
        ("i_ch1_t2", "i_ch1", "Types of Loans", 2),
        ("i_ch1_t3", "i_ch1", "Interest and Fees", 3),

        ("i_ch2_t1", "i_ch2", "What Is a Credit Score?", 1),
        ("i_ch2_t2", "i_ch2", "Factors Affecting Credit Score", 2),
        ("i_ch2_t3", "i_ch2", "Improving Your Credit Score", 3),

        ("i_ch3_t1", "i_ch3", "Understanding Debt", 1),
        ("i_ch3_t2", "i_ch3", "Debt Repayment Methods", 2),
        ("i_ch3_t3", "i_ch3", "Avoiding Debt Traps", 3),

        ("i_ch4_t1", "i_ch4", "Setting Financial Goals", 1),
        ("i_ch4_t2", "i_ch4", "Creating a Financial Plan", 2),
        ("i_ch4_t3", "i_ch4", "Tracking Progress", 3),

        ("i_ch5_t1", "i_ch5", "Ways to Increase Income", 1),
        ("i_ch5_t2", "i_ch5", "Starting Side Hustles", 2),
        ("i_ch5_t3", "i_ch5", "Managing Multiple Incomes", 3),
        
        // Advanced
        ("a_ch1_t1", "a_ch1", "What Is Investing?", 1),
        ("a_ch1_t2", "a_ch1", "Types of Investments", 2),
        ("a_ch1_t3", "a_ch1", "Core Investment Principles", 3),

        ("a_ch2_t1", "a_ch2", "Understanding Investment Risk", 1),
        ("a_ch2_t2", "a_ch2", "Diversification Strategies", 2),
        ("a_ch2_t3", "a_ch2", "Managing and Reducing Risk", 3),

        ("a_ch3_t1", "a_ch3", "Retirement Needs Assessment", 1),
        ("a_ch3_t2", "a_ch3", "Retirement Savings Vehicles", 2),
        ("a_ch3_t3", "a_ch3", "Retirement Withdrawal Planning", 3),

        ("a_ch4_t1", "a_ch4", "Power of Compound Growth", 1),
        ("a_ch4_t2", "a_ch4", "Asset Allocation Strategies", 2),
        ("a_ch4_t3", "a_ch4", "Advanced Wealth Building Approaches", 3),

        ("a_ch5_t1", "a_ch5", "Path to Financial Independence", 1),
        ("a_ch5_t2", "a_ch5", "Estate & Legacy Planning", 2),
        ("a_ch5_t3", "a_ch5", "Building Generational Wealth", 3)
    ]
    
    // MARK: - Objectives
    static let objectives: [(id: String, topicId: String, title: String, content: String, order: Int)] = [
        ("obj_b_ch1_t1_1", "b_ch1_t1", "Understand what financial literacy means", "Definition of financial literacy", 1),
        ("obj_b_ch1_t1_2", "b_ch1_t1", "Identify the key areas of financial literacy", "Key areas of money management", 2),
        ("obj_b_ch1_t1_3", "b_ch1_t1", "Relate financial literacy to everyday decisions", "Daily money decisions", 3),

        ("obj_b_ch2_t1_1", "b_ch2_t1", "Define saving", "Meaning of saving", 1),
        ("obj_b_ch2_t1_2", "b_ch2_t1", "Understand why people save", "Reasons for saving", 2),
        ("obj_b_ch2_t1_3", "b_ch2_t1", "Differentiate saving from spending", "Saving vs spending", 3),

        ("obj_b_ch3_t1_1", "b_ch3_t1", "Understand what a bank does", "Role of banks", 1),
        ("obj_b_ch3_t1_2", "b_ch3_t1", "Identify banking services", "Bank services", 2),
        ("obj_b_ch3_t1_3", "b_ch3_t1", "Explain why banks are important", "Importance of banks", 3),
        
        ("obj_b_ch4_t1_1", "b_ch4_t1", "What Is Budgeting?", "Understanding budgeting", 1),
        ("obj_b_ch4_t1_2", "b_ch4_t1", "Income and Expenses", "Income vs Expenses", 2),
        ("obj_b_ch4_t1_3", "b_ch4_t1", "Spending Categories", "Categorizing spending", 3),
        
        ("obj_b_ch5_t1_1", "b_ch5_t1", "What Are Needs?", "Defining needs", 1),
        ("obj_b_ch5_t2_1", "b_ch5_t2", "What Are Wants?", "Defining wants", 1),
        ("obj_b_ch5_t3_1", "b_ch5_t3", "Making Smart Choices", "Prioritizing needs", 1),
        
        // Intermediate
        ("obj_i_ch1_t1_1", "i_ch1_t1", "Define credit and its purpose", "Credit is borrowed money that must be repaid with interest. It allows access to funds for needs like buying a home or starting a business.", 1),
        ("obj_i_ch1_t1_2", "i_ch1_t1", "Explain how credit works", "Credit involves lenders providing money based on your ability to repay. Repayment includes principal plus interest over time.", 2),
        ("obj_i_ch1_t1_3", "i_ch1_t1", "Identify benefits and risks of credit", "Benefits include building assets; risks involve debt accumulation if not managed well.", 3),
        
        ("obj_i_ch1_t2_1", "i_ch1_t2", "Describe personal loans", "Personal loans are unsecured funds for general use, repaid in installments with interest.", 1),
        ("obj_i_ch1_t2_2", "i_ch1_t2", "Explain mortgages and car loans", "Mortgages are for homes, car loans for vehicles; both are secured by the asset.", 2),
        ("obj_i_ch1_t2_3", "i_ch1_t2", "Discuss business and education loans", "Business loans fund ventures; education loans cover schooling costs.", 3),
        
        ("obj_i_ch1_t3_1", "i_ch1_t3", "Understand interest rates", "Interest is the cost of borrowing, calculated as a percentage of the loan amount.", 1),
        ("obj_i_ch1_t3_2", "i_ch1_t3", "Explain fees associated with loans", "Fees include processing, late payment, and prepayment penalties.", 2),
        ("obj_i_ch1_t3_3", "i_ch1_t3", "Calculate simple interest", "Simple interest is principal times rate times time.", 3),
        
        ("obj_i_ch2_t1_1", "i_ch2_t1", "Define credit score", "A credit score is a number representing your creditworthiness based on financial history.", 1),
        ("obj_i_ch2_t1_2", "i_ch2_t1", "Explain credit scoring models", "Models like FICO evaluate payment history, debt levels, and credit age.", 2),
        ("obj_i_ch2_t1_3", "i_ch2_t1", "Identify score ranges", "Scores range from poor (below 580) to excellent (above 800).", 3),
        
        ("obj_i_ch2_t2_1", "i_ch2_t2", "Discuss payment history", "Timely payments positively impact your score.", 1),
        ("obj_i_ch2_t2_2", "i_ch2_t2", "Explain credit utilization", "Utilization is the ratio of debt to credit limits; keep below 30%.", 2),
        ("obj_i_ch2_t2_3", "i_ch2_t2", "Cover length of credit history", "Longer history generally improves scores.", 3),
        
        ("obj_i_ch2_t3_1", "i_ch2_t3", "Pay bills on time", "Consistent payments build positive history.", 1),
        ("obj_i_ch2_t3_2", "i_ch2_t3", "Reduce debt levels", "Lowering balances improves utilization.", 2),
        ("obj_i_ch2_t3_3", "i_ch2_t3", "Avoid new credit applications", "Too many inquiries can lower scores.", 3),
        
        ("obj_i_ch3_t1_1", "i_ch3_t1", "Define good and bad debt", "Good debt builds assets; bad debt funds depreciating items.", 1),
        ("obj_i_ch3_t1_2", "i_ch3_t1", "Assess debt levels", "Calculate debt-to-income ratio for health check.", 2),
        ("obj_i_ch3_t1_3", "i_ch3_t1", "Recognize debt warning signs", "Signs include minimum payments only or borrowing for bills.", 3),
        
        ("obj_i_ch3_t2_1", "i_ch3_t2", "Explain snowball method", "Pay smallest debts first for motivation.", 1),
        ("obj_i_ch3_t2_2", "i_ch3_t2", "Describe avalanche method", "Target highest interest debts to save money.", 2),
        ("obj_i_ch3_t2_3", "i_ch3_t2", "Discuss consolidation", "Combine debts into one loan for simpler payments.", 3),
        
        ("obj_i_ch3_t3_1", "i_ch3_t3", "Budget to avoid new debt", "Live within means to prevent accumulation.", 1),
        ("obj_i_ch3_t3_2", "i_ch3_t3", "Build emergency fund", "Savings cover unexpected costs without borrowing.", 2),
        ("obj_i_ch3_t3_3", "i_ch3_t3", "Seek professional advice", "Counselors help negotiate better terms.", 3),
        
        ("obj_i_ch4_t1_1", "i_ch4_t1", "Set short-term goals", "Goals like saving for a phone achievable in months.", 1),
        ("obj_i_ch4_t1_2", "i_ch4_t1", "Define long-term goals", "Goals like home ownership over years.", 2),
        ("obj_i_ch4_t1_3", "i_ch4_t1", "Make goals SMART", "Specific, measurable, achievable, relevant, time-bound.", 3),
        
        ("obj_i_ch4_t2_1", "i_ch4_t2", "Assess current finances", "Review income, expenses, assets, debts.", 1),
        ("obj_i_ch4_t2_2", "i_ch4_t2", "Allocate resources", "Assign money to goals and expenses.", 2),
        ("obj_i_ch4_t2_3", "i_ch4_t2", "Include contingencies", "Plan for unexpected events.", 3),
        
        ("obj_i_ch4_t3_1", "i_ch4_t3", "Monitor spending", "Track expenses against budget regularly.", 1),
        ("obj_i_ch4_t3_2", "i_ch4_t3", "Review progress", "Check goal achievement monthly.", 2),
        ("obj_i_ch4_t3_3", "i_ch4_t3", "Adjust plans", "Modify based on changes or setbacks.", 3),
        
        ("obj_i_ch5_t1_1", "i_ch5_t1", "Negotiate salary", "Ask for raises based on performance.", 1),
        ("obj_i_ch5_t1_2", "i_ch5_t1", "Acquire new skills", "Learn to qualify for better jobs.", 2),
        ("obj_i_ch5_t1_3", "i_ch5_t1", "Change careers", "Switch to higher-paying fields.", 3),
        
        ("obj_i_ch5_t2_1", "i_ch5_t2", "Identify opportunities", "Find hustles matching skills like tutoring.", 1),
        ("obj_i_ch5_t2_2", "i_ch5_t2", "Start small", "Begin with low-cost ideas like selling produce.", 2),
        ("obj_i_ch5_t2_3", "i_ch5_t2", "Scale up", "Grow successful hustles into businesses.", 3),
        
        ("obj_i_ch5_t3_1", "i_ch5_t3", "Track incomes separately", "Monitor earnings from each source.", 1),
        ("obj_i_ch5_t3_2", "i_ch5_t3", "Manage taxes", "Report all incomes accurately.", 2),
        ("obj_i_ch5_t3_3", "i_ch5_t3", "Balance time", "Avoid burnout with scheduling.", 3),
        
        // Advanced
        ("obj_a_ch1_t1_1", "a_ch1_t1", "Define investing", "Investing is putting money into assets expecting them to grow in value or generate income over time.", 1),
        ("obj_a_ch1_t1_2", "a_ch1_t1", "Understand returns", "Returns come from capital appreciation, dividends, interest, or rental income.", 2),
        ("obj_a_ch1_t1_3", "a_ch1_t1", "Differentiate investing from saving", "Investing seeks growth with risk; saving focuses on safety and liquidity.", 3),
        
        ("obj_a_ch1_t2_1", "a_ch1_t2", "Understand stocks", "Stocks represent ownership in companies and offer growth potential through price increase and dividends.", 1),
        ("obj_a_ch1_t2_2", "a_ch1_t2", "Understand bonds", "Bonds are loans to governments or companies that pay regular interest and return principal at maturity.", 2),
        ("obj_a_ch1_t2_3", "a_ch1_t2", "Explore other assets", "Real estate, mutual funds, ETFs, and commodities provide different risk-return profiles.", 3),
        
        ("obj_a_ch1_t3_1", "a_ch1_t3", "Time in the market", "Longer investment periods generally reduce risk and increase potential returns.", 1),
        ("obj_a_ch1_t3_2", "a_ch1_t3", "Risk vs reward relationship", "Higher potential returns usually come with higher risk of loss.", 2),
        ("obj_a_ch1_t3_3", "a_ch1_t3", "Set clear goals", "Investment decisions should align with specific financial objectives and time horizons.", 3),
        
        ("obj_a_ch2_t1_1", "a_ch2_t1", "Identify types of risk", "Market, inflation, interest rate, liquidity, and business-specific risks affect investments.", 1),
        ("obj_a_ch2_t1_2", "a_ch2_t1", "Measure investment risk", "Volatility, standard deviation, and beta help quantify how much an investment fluctuates.", 2),
        ("obj_a_ch2_t1_3", "a_ch2_t1", "Assess personal risk tolerance", "Your ability and willingness to handle investment losses determines suitable strategies.", 3),
        
        ("obj_a_ch2_t2_1", "a_ch2_t2", "Spread across asset classes", "Combining stocks, bonds, real estate, and cash reduces overall portfolio risk.", 1),
        ("obj_a_ch2_t2_2", "a_ch2_t2", "Geographic diversification", "Investing in Rwanda, East Africa, and global markets reduces country-specific risk.", 2),
        ("obj_a_ch2_t2_3", "a_ch2_t2", "Regular portfolio rebalancing", "Adjusting allocations back to target percentages maintains desired risk level.", 3),
        
        ("obj_a_ch2_t3_1", "a_ch2_t3", "Use stop-loss strategies", "Automatic selling at predetermined prices limits potential losses.", 1),
        ("obj_a_ch2_t3_2", "a_ch2_t3", "Hedging techniques", "Options and other derivatives can protect against significant market declines.", 2),
        ("obj_a_ch2_t3_3", "a_ch2_t3", "Maintain emergency reserves", "Cash reserves prevent forced selling of investments during emergencies.", 3),
        
        ("obj_a_ch3_t1_1", "a_ch3_t1", "Estimate retirement expenses", "Project monthly living costs, healthcare, and lifestyle in retirement years.", 1),
        ("obj_a_ch3_t1_2", "a_ch3_t1", "Account for inflation", "Future expenses will be higher due to rising prices over decades.", 2),
        ("obj_a_ch3_t1_3", "a_ch3_t1", "Factor in life expectancy", "Plan for 25–35 years of retirement income depending on current age.", 3),
        
        ("obj_a_ch3_t2_1", "a_ch3_t2", "Understand RSSB pension", "Rwanda Social Security Board provides mandatory retirement benefits for formal workers.", 1),
        ("obj_a_ch3_t2_2", "a_ch3_t2", "Use voluntary savings plans", "Personal pension schemes and retirement investment accounts offer tax advantages.", 2),
        ("obj_a_ch3_t2_3", "a_ch3_t2", "Consider annuities", "Insurance products that convert savings into guaranteed lifetime income.", 3),
        
        ("obj_a_ch3_t3_1", "a_ch3_t3", "Apply safe withdrawal rates", "The 4% rule suggests withdrawing 4% of portfolio in first year, adjusted for inflation.", 1),
        ("obj_a_ch3_t3_2", "a_ch3_t3", "Sequence of returns risk", "Poor market returns early in retirement can significantly impact portfolio longevity.", 2),
        ("obj_a_ch3_t3_3", "a_ch3_t3", "Flexible withdrawal strategies", "Adjust withdrawals based on market performance and personal needs.", 3),
        
        ("obj_a_ch4_t1_1", "a_ch4_t1", "Understand compounding", "Earnings generate additional earnings, creating exponential growth over time.", 1),
        ("obj_a_ch4_t1_2", "a_ch4_t1", "Start investing early", "Time is the most powerful factor in building substantial wealth.", 2),
        ("obj_a_ch4_t1_3", "a_ch4_t1", "Reinvest returns", "Dividends and interest reinvested accelerate the compounding effect.", 3),
        
        ("obj_a_ch4_t2_1", "a_ch4_t2", "Age-based allocation", "Younger investors can afford more stocks; older investors shift toward bonds.", 1),
        ("obj_a_ch4_t2_2", "a_ch4_t2", "Target-date approach", "Automatically adjusts asset mix as retirement date approaches.", 2),
        ("obj_a_ch4_t2_3", "a_ch4_t2", "Tax-efficient placement", "Place tax-inefficient investments in tax-advantaged accounts when possible.", 3),
        
        ("obj_a_ch4_t3_1", "a_ch4_t3", "Value investing approach", "Buy quality assets when they are undervalued relative to fundamentals.", 1),
        ("obj_a_ch4_t3_2", "a_ch4_t3", "Dividend growth strategy", "Focus on companies that consistently increase dividend payments.", 2),
        ("obj_a_ch4_t3_3", "a_ch4_t3", "Passive vs active management", "Low-cost index investing often outperforms active stock picking over long periods.", 3),
        
        ("obj_a_ch5_t1_1", "a_ch5_t1", "Calculate FI number", "Financial independence number is typically 25–30 times annual expenses.", 1),
        ("obj_a_ch5_t1_2", "a_ch5_t1", "Increase savings rate", "Higher percentage of income saved accelerates path to independence.", 2),
        ("obj_a_ch5_t1_3", "a_ch5_t1", "Build multiple income streams", "Diversified income reduces reliance on single job or investment.", 3),
        
        ("obj_a_ch5_t2_1", "a_ch5_t2", "Create a will", "Legal document specifying how assets should be distributed after death.", 1),
        ("obj_a_ch5_t2_2", "a_ch5_t2", "Use trusts when appropriate", "Trusts can provide control, tax benefits, and protection for heirs.", 2),
        ("obj_a_ch5_t2_3", "a_ch5_t2", "Update beneficiaries", "Regularly review and update beneficiary designations on accounts.", 3),
        
        ("obj_a_ch5_t3_1", "a_ch5_t3", "Teach financial literacy", "Educating children and grandchildren about money builds lasting wealth.", 1),
        ("obj_a_ch5_t3_2", "a_ch5_t3", "Strategic gifting", "Giving assets during lifetime can reduce estate taxes and help family.", 2),
        ("obj_a_ch5_t3_3", "a_ch5_t3", "Philanthropic legacy", "Establishing charitable giving creates impact beyond family wealth.", 3)
    ]
    
    // MARK: - Lessons
    static let lessons: [(id: String, objectiveId: String, title: String, paragraph: String, keyTakeaway: String)] = [
        (
            "lesson_obj_b_ch1_t1_1",
            "obj_b_ch1_t1_1",
            "What Is Financial Literacy?",
            "Financial literacy is the ability to understand and manage your money wisely so that it works for you instead of against you. It includes knowing how money is earned, how to spend responsibly, how to save for future needs, how to invest to grow money over time, and how to protect yourself from financial risks such as emergencies or fraud.\n\nImagine two people earning RWF 500,000 per month. One plans their expenses, saves RWF 25,000, and finishes the month calm and prepared. The other spends without planning, runs out of money early, borrows RWF 50,000, and ends the month stressed and in debt. The difference is not income, but money management.",
            "Financial literacy is not about being rich. It is about making smart choices with the money you already have."
        ),
        (
            "lesson_obj_b_ch1_t1_2",
            "obj_b_ch1_t1_2",
            "Key Areas of Financial Literacy",
            "Financial literacy is built on five key areas: earning, spending, saving, investing, and protecting money. Earning is how you get money, such as salary or business income. Spending is how you use money for food, rent, and transport. Saving means keeping money for future needs. Investing allows money to grow over time, and protection helps avoid loss from emergencies or fraud.\n\nFor example, someone who earns regularly but spends everything without saving may struggle during emergencies, while someone who understands all five areas stays more financially secure.",
            "Understanding all areas of money management helps you stay in control of your finances."
        ),
        (
            "lesson_obj_b_ch1_t1_3",
            "obj_b_ch1_t1_3",
            "Financial Literacy in Daily Life",
            "Financial literacy affects everyday decisions such as choosing between saving or spending, budgeting for food, or avoiding unnecessary mobile money fees. Small choices made daily can build financial stability or lead to stress.\n\nFor example, buying lunch every day instead of cooking at home may seem small, but over a month it can significantly reduce savings.",
            "Small daily money decisions have a big impact over time."
        ),
        (
            "lesson_obj_b_ch2_t1_1",
            "obj_b_ch2_t1_1",
            "What Does Saving Mean?",
            "Saving means setting aside a portion of your money for future use instead of spending everything immediately. Saving helps prepare for emergencies and planned goals.\n\nFor example, saving RWF 2,000 daily can help cover medical costs or school fees without borrowing.",
            "Saving today protects you tomorrow."
        ),
        (
            "lesson_obj_b_ch2_t1_2",
            "obj_b_ch2_t1_2",
            "Why People Save",
            "People save money to handle emergencies, pay school fees, start businesses, or plan for the future. Savings provide security and independence.\n\nSomeone with savings can handle unexpected expenses calmly, while someone without savings may rely on loans or support from others.",
            "Saving gives you freedom and security."
        ),
        (
            "lesson_obj_b_ch2_t1_3",
            "obj_b_ch2_t1_3",
            "Saving vs Spending",
            "Spending satisfies immediate needs or wants such as food or entertainment, while saving prepares for future needs. Both are important, but saving ensures long-term stability.\n\nFor example, spending all income on wants may feel good short term but creates problems later.",
            "Balance spending today with saving for tomorrow."
        ),
        (
            "lesson_obj_b_ch3_t1_1",
            "obj_b_ch3_t1_1",
            "What Banks Do",
            "Banks store money safely, allow people to make payments, and provide financial services. Keeping money in a bank reduces the risk of loss compared to carrying cash.\n\nFor example, money stored in a bank account is safer than keeping it at home.",
            "Banks help protect and manage your money."
        ),
        (
            "lesson_obj_b_ch3_t1_2",
            "obj_b_ch3_t1_2",
            "Banking Services",
            "Banks offer services such as savings accounts, current accounts, loans, and mobile banking. These services help people manage money efficiently.\n\nFor example, mobile banking allows checking balances and transferring money easily.",
            "Bank services make money management easier and safer."
        ),
        (
            "lesson_obj_b_ch3_t1_3",
            "obj_b_ch3_t1_3",
            "Why Banks Matter",
            "Banks support economic growth by providing safe financial systems. They help individuals save, borrow responsibly, and invest.\n\nA strong banking system benefits both individuals and the wider economy.",
            "Banks play a key role in financial stability."
        ),
        (
            "lesson_obj_b_ch4_t1_1",
            "obj_b_ch4_t1_1",
            "What Is Budgeting?",
            "Budgeting is planning how money is earned and spent to avoid overspending. A budget helps track expenses and savings.\n\nFor example, listing monthly income and expenses helps prevent running out of money early.",
            "A budget gives direction to your money."
        ),
        (
            "lesson_obj_b_ch4_t1_2",
            "obj_b_ch4_t1_2",
            "Income and Expenses",
            "Income is money earned, while expenses are money spent. Understanding both helps create a realistic budget.\n\nKnowing how much you earn and spend helps avoid financial surprises.",
            "You must know your income and expenses to control money."
        ),
        (
            "lesson_obj_b_ch4_t1_3",
            "obj_b_ch4_t1_3",
            "Spending Categories",
            "Expenses can be grouped into needs, wants, and savings. Categorizing spending improves budgeting accuracy.\n\nFor example, rent is a need, entertainment is a want, and savings prepare for the future.",
            "Categorizing expenses helps control spending."
        ),
        (
            "lesson_obj_b_ch5_t1_1",
            "obj_b_ch5_t1_1",
            "What Are Needs?",
            "Needs are basic requirements such as food, shelter, and healthcare. These must be prioritized in spending decisions.\n\nWithout meeting needs, daily life becomes difficult.",
            "Needs should always come first."
        ),
        (
            "lesson_obj_b_ch5_t2_1",
            "obj_b_ch5_t2_1",
            "What Are Wants?",
            "Wants are items that improve comfort but are not essential. Spending too much on wants reduces savings.\n\nExamples include entertainment and luxury items.",
            "Wants should not replace essential needs."
        ),
        (
            "lesson_obj_b_ch5_t3_1",
            "obj_b_ch5_t3_1",
            "Making Smart Choices",
            "Smart spending involves prioritizing needs before wants and thinking before making purchases.\n\nMaking informed decisions helps avoid regret and stress.",
            "Smart choices today lead to financial stability tomorrow."
        ),
        // Intermediate
        (
            "lesson_obj_i_ch1_t1_1",
            "obj_i_ch1_t1_1",
            "Defining Credit",
            "Credit is borrowed money that you must repay later, usually with interest added. It allows you to buy things now when you don't have enough cash, such as a motorbike, land, or starting capital for a small business. \n\nImagine two people who want to buy a motorbike worth RWF 1,200,000. One uses savings and pays cash, while the other takes credit, buys immediately, and repays monthly — but ends up paying RWF 1,500,000 total because of interest.",
            "Credit is a tool for growth when used responsibly."
        ),
        (
            "lesson_obj_i_ch1_t1_2",
            "obj_i_ch1_t1_2",
            "How Credit Functions",
            "When you take credit, the lender gives you money based on your income and repayment ability, and you must return it plus interest in regular installments. Good repayment history helps you borrow more easily in the future, while missing payments makes future loans harder or more expensive. \n\nImagine two friends borrowing RWF 800,000 for school fees. One pays every month on time and later gets a bigger loan at lower interest, while the other misses payments and struggles to borrow again.",
            "Repayment builds or breaks your financial reputation."
        ),
        (
            "lesson_obj_i_ch1_t1_3",
            "obj_i_ch1_t1_3",
            "Benefits and Risks",
            "Credit can help you build assets like a house or grow a business faster, but if not managed well it leads to high interest costs and long-term debt stress. The key is borrowing only what you can comfortably repay. \n\nImagine two people taking RWF 2,000,000 credit. One invests in a profitable shop and repays easily, while the other buys luxury items and ends up struggling with monthly payments for years.",
            "Weigh benefits against risks before borrowing."
        ),
        (
            "lesson_obj_i_ch1_t2_1",
            "obj_i_ch1_t2_1",
            "Personal Loans Explained",
            "Personal loans give you cash for any purpose without needing to give collateral, and you repay in fixed monthly amounts plus interest. They are convenient but usually have higher interest rates because the bank takes more risk. \n\nImagine two people needing RWF 600,000 for a wedding. One takes a personal loan and repays RWF 70,000 monthly, while the other borrows from family and avoids interest completely.",
            "Personal loans offer flexibility but cost more."
        ),
        (
            "lesson_obj_i_ch1_t2_2",
            "obj_i_ch1_t2_2",
            "Mortgages and Car Loans",
            "Mortgages and car loans are secured by the house or vehicle you buy, so the bank can take the asset if you don't repay. They usually have lower interest rates because of this security and longer repayment periods. \n\nImagine two families wanting a house worth RWF 15,000,000. One takes a mortgage and pays over 15 years while living in the house, while the other saves slowly and rents for many years.",
            "Secured loans build long-term assets."
        ),
        (
            "lesson_obj_i_ch1_t2_3",
            "obj_i_ch1_t2_3",
            "Business and Education Loans",
            "Business loans help start or grow a venture, while education loans pay for school fees, books, and training to increase future earning power. Both are investments in your ability to earn more later. \n\nImagine two young people. One takes RWF 4,000,000 education loan, studies, gets a better job, and repays easily, while the other avoids debt but takes longer to advance in career.",
            "These loans invest in future income potential."
        ),
        (
            "lesson_obj_i_ch1_t3_1",
            "obj_i_ch1_t3_1",
            "Interest Rates Basics",
            "Interest is the extra amount you pay for borrowing money, expressed as a percentage of the loan amount, and it can be fixed or changing. Lower interest rates mean you pay less overall. \n\nImagine two people borrowing RWF 1,000,000. One gets 12% interest and pays RWF 120,000 extra per year, while the other finds 8% and pays only RWF 80,000 extra per year.",
            "Shop for the lowest rates possible."
        ),
        (
            "lesson_obj_i_ch1_t3_2",
            "obj_i_ch1_t3_2",
            "Loan Fees Overview",
            "Besides interest, loans often come with extra costs like processing fees, insurance, or late payment penalties that increase the total amount you repay. Always read all charges before signing. \n\nImagine two loans of RWF 500,000. One has RWF 15,000 in fees and the other has RWF 50,000 — the first one saves you RWF 35,000 right from the start.",
            "Factor all fees into borrowing decisions."
        ),
        (
            "lesson_obj_i_ch1_t3_3",
            "obj_i_ch1_t3_3",
            "Calculating Simple Interest",
            "Simple interest is calculated only on the original amount borrowed (principal) using the formula: principal × rate × time. It's easier to understand for short-term loans. \n\nImagine borrowing RWF 800,000 at 10% for 2 years. You pay RWF 160,000 in interest, making the total repayment RWF 960,000 — knowing this helps you plan better.",
            "Calculate to know true loan costs."
        ),
        (
            "lesson_obj_i_ch2_t1_1",
            "obj_i_ch2_t1_1",
            "Credit Score Definition",
            "A credit score is a three-digit number that shows banks how reliable you are at repaying borrowed money based on your past financial behavior. Higher scores get you better loan terms. \n\nImagine two people applying for a RWF 3,000,000 loan. One with a good score gets 10% interest, while the one with a poor score is charged 18% or even denied.",
            "Scores reflect your financial trustworthiness."
        ),
        (
            "lesson_obj_i_ch2_t1_2",
            "obj_i_ch2_t1_2",
            "Scoring Models",
            "Credit scoring models look at your payment history, amount of debt, length of credit history, and new credit applications to give you a score. Consistent good habits raise your score over time. \n\nImagine two people with similar incomes. One always pays on time and keeps low debt, getting an excellent score, while the other has late payments and high balances, receiving a low score.",
            "Understand models to improve scores."
        ),
        (
            "lesson_obj_i_ch2_t1_3",
            "obj_i_ch2_t1_3",
            "Score Ranges",
            "Credit scores are grouped into ranges: poor (below 580), fair, good, very good, and excellent (above 800). Higher ranges unlock lower interest rates and more approvals. \n\nImagine two borrowers. One with an excellent score easily gets a car loan at low interest, while one with a poor score either gets rejected or pays much higher rates.",
            "Higher scores open better opportunities."
        ),
        (
            "lesson_obj_i_ch2_t2_1",
            "obj_i_ch2_t2_1",
            "Payment History Impact",
            "Payment history is the most important factor in your credit score — paying on time every month builds a strong positive record, while late payments hurt it for years. \n\nImagine two people with credit cards. One pays the RWF 80,000 balance in full every month and improves their score, while the other pays late several times and sees their score drop significantly.",
            "Timeliness is key to good history."
        ),
        (
            "lesson_obj_i_ch2_t2_2",
            "obj_i_ch2_t2_2",
            "Credit Utilization",
            "Credit utilization is how much of your available credit you are using — keeping it below 30% shows you manage credit well and helps your score. \n\nImagine two people with RWF 1,000,000 credit limits. One uses only RWF 200,000 (20%) and has a strong score, while the other uses RWF 900,000 (90%) and sees their score suffer.",
            "Low utilization signals responsibility."
        ),
        (
            "lesson_obj_i_ch2_t2_3",
            "obj_i_ch2_t2_3",
            "Credit History Length",
            "The longer you have had credit accounts in good standing, the better it looks to lenders — older accounts show stability and responsibility. \n\nImagine two people the same age. One has used credit responsibly for 8 years and gets excellent offers, while the other only started last year and has a shorter, weaker history.",
            "Time builds credit strength."
        ),
        (
            "lesson_obj_i_ch2_t3_1",
            "obj_i_ch2_t3_1",
            "Timely Bill Payments",
            "Paying all bills — loans, mobile money, electricity, water — on or before the due date is the fastest way to build and maintain a good credit score. \n\nImagine two people with RWF 150,000 monthly loan payments. One sets automatic payments and never misses, steadily raising their score, while the other sometimes pays late and hurts their record.",
            "Consistency raises scores steadily."
        ),
        (
            "lesson_obj_i_ch2_t3_2",
            "obj_i_ch2_t3_2",
            "Reducing Debts",
            "Paying down your existing balances, especially on credit cards, lowers your credit utilization and usually improves your score quickly. \n\nImagine two people with RWF 400,000 credit card balances. One aggressively pays down to RWF 100,000 and sees their score rise, while the other keeps the balance high and the score stays low.",
            "Less debt means better scores."
        ),
        (
            "lesson_obj_i_ch2_t3_3",
            "obj_i_ch2_t3_3",
            "Limiting Applications",
            "Every time you apply for new credit, it creates a hard inquiry that can temporarily lower your score — too many in a short time look risky to lenders. \n\nImagine two people. One applies for three loans in one month and sees their score drop, while the other waits several months between applications and keeps their score stable.",
            "Fewer inquiries preserve scores."
        ),
        (
            "lesson_obj_i_ch3_t1_1",
            "obj_i_ch3_t1_1",
            "Good vs Bad Debt",
            "Good debt helps you build wealth or increase income (like a house or business loan), while bad debt pays for things that lose value quickly (like luxury phones on credit). \n\nImagine two people borrowing RWF 5,000,000. One buys rental property that generates income, while the other buys a fancy car that depreciates fast — one builds wealth, the other loses.",
            "Choose debt that adds value."
        ),
        (
            "lesson_obj_i_ch3_t1_2",
            "obj_i_ch3_t1_2",
            "Assessing Debt Levels",
            "Your debt-to-income ratio shows how much of your monthly income goes to debt payments — keeping it under 36–40% is considered healthy. \n\nImagine two people earning RWF 700,000 monthly. One has debt payments of RWF 200,000 (28%) and is comfortable, while the other has RWF 350,000 (50%) and struggles every month.",
            "Monitor ratios for financial health."
        ),
        (
            "lesson_obj_i_ch3_t1_3",
            "obj_i_ch3_t1_3",
            "Debt Warning Signs",
            "Warning signs include only paying minimum amounts, using new credit to pay old debts, or borrowing money for daily living expenses. \n\nImagine two people. One pays credit card minimums and keeps borrowing more, sinking deeper, while the other notices early and cuts spending to get control.",
            "Recognize signs early to act."
        ),
        (
            "lesson_obj_i_ch3_t2_1",
            "obj_i_ch3_t2_1",
            "Snowball Method",
            "The snowball method pays off smallest debts first for quick wins and motivation, then rolls those payments into the next debt. \n\nImagine two people with multiple debts. One clears the RWF 80,000 debt first, feels motivated, and keeps going, while the other feels overwhelmed and stops trying.",
            "Momentum from small victories."
        ),
        (
            "lesson_obj_i_ch3_t2_2",
            "obj_i_ch3_t2_2",
            "Avalanche Method",
            "The avalanche method attacks the highest-interest debt first, saving the most money on interest over time. \n\nImagine two people owing RWF 1,200,000 total. One pays the 22% interest debt first and saves thousands, while the other pays the lowest interest first and pays more overall.",
            "Saves money long-term."
        ),
        (
            "lesson_obj_i_ch3_t2_3",
            "obj_i_ch3_t2_3",
            "Debt Consolidation",
            "Debt consolidation combines several high-interest debts into one loan with a lower interest rate and single monthly payment. \n\nImagine someone with three loans totaling RWF 1,800,000 at different high rates. They consolidate into one loan at lower interest and pay less each month, making repayment easier.",
            "Simplifies and potentially reduces costs."
        ),
        (
            "lesson_obj_i_ch3_t3_1",
            "obj_i_ch3_t3_1",
            "Budgeting to Avoid Debt",
            "Living on a strict budget where you spend less than you earn prevents the need to borrow for daily expenses or emergencies. \n\nImagine two people earning RWF 600,000 monthly. One follows a budget and saves RWF 50,000 each month, while the other spends everything and borrows when unexpected costs come.",
            "Prevention through planning."
        ),
        (
            "lesson_obj_i_ch3_t3_2",
            "obj_i_ch3_t3_2",
            "Emergency Fund Building",
            "An emergency fund of 3–6 months of living expenses in savings prevents you from borrowing when unexpected costs appear. \n\nImagine two people facing a RWF 800,000 medical bill. One has savings and pays easily, while the other has nothing and must take expensive credit.",
            "Savings replace borrowing needs."
        ),
        (
            "lesson_obj_i_ch3_t3_3",
            "obj_i_ch3_t3_3",
            "Professional Advice",
            "Credit counselors or financial advisors can help negotiate lower interest rates, create repayment plans, or guide you out of debt trouble. \n\nImagine two people deep in debt. One seeks professional help and gets better terms, while the other continues alone and pays much more interest over time.",
            "Expert help eases debt burden."
        ),
        (
            "lesson_obj_i_ch4_t1_1",
            "obj_i_ch4_t1_1",
            "Short-Term Goals",
            "Short-term financial goals are things you want to achieve in the next 6–24 months, like saving for a phone, wedding, or emergency fund. \n\nImagine two people. One sets a goal to save RWF 400,000 in 12 months and achieves it, while the other has no plan and spends the money on small wants.",
            "Start small for success."
        ),
        (
            "lesson_obj_i_ch4_t1_2",
            "obj_i_ch4_t1_2",
            "Long-Term Goals",
            "Long-term goals are big dreams that take many years, such as buying land, building a house, or retiring comfortably. \n\nImagine two people in their 30s. One starts saving RWF 30,000 monthly toward a house and succeeds in 15 years, while the other waits and struggles later.",
            "Vision for future security."
        ),
        (
            "lesson_obj_i_ch4_t1_3",
            "obj_i_ch4_t1_3",
            "SMART Goals",
            "SMART goals are Specific, Measurable, Achievable, Relevant, and Time-bound, making them much easier to reach. \n\nImagine two people wanting to save. One says 'save RWF 50,000 every month for 18 months for a motorbike' (SMART), while the other just says 'save money' and never reaches the goal.",
            "Structure ensures achievement."
        ),
        (
            "lesson_obj_i_ch4_t2_1",
            "obj_i_ch4_t2_1",
            "Financial Assessment",
            "A financial assessment means honestly listing your current income, monthly expenses, assets, and debts to know exactly where you stand. \n\nImagine two people. One calculates net worth and sees they have RWF 2,000,000 more assets than debts, while the other avoids looking and stays surprised by money problems.",
            "Know starting point."
        ),
        (
            "lesson_obj_i_ch4_t2_2",
            "obj_i_ch4_t2_2",
            "Resource Allocation",
            "Resource allocation means deciding how much of your income goes to needs, wants, savings, and debt repayment each month. \n\nImagine two people earning RWF 800,000. One allocates 50% needs, 20% savings, 20% debt, 10% wants and progresses, while the other spends freely and stays stuck.",
            "Prioritize effectively."
        ),
        (
            "lesson_obj_i_ch4_t2_3",
            "obj_i_ch4_t2_3",
            "Contingency Planning",
            "Contingency planning means setting aside extra money or having backup plans for unexpected events like job loss, illness, or price increases. \n\nImagine two families. One has a contingency fund and handles a RWF 1,000,000 emergency calmly, while the other has no plan and falls into debt.",
            "Prepare for uncertainties."
        ),
        (
            "lesson_obj_i_ch4_t3_1",
            "obj_i_ch4_t3_1",
            "Spending Monitoring",
            "Monitoring spending means tracking every Rwandan franc you spend daily or weekly to see where your money really goes. \n\nImagine two people. One tracks expenses in an app and cuts unnecessary spending, while the other never checks and wonders why money disappears.",
            "Awareness controls spending."
        ),
        (
            "lesson_obj_i_ch4_t3_2",
            "obj_i_ch4_t3_2",
            "Progress Review",
            "Regular progress reviews mean checking monthly or quarterly how close you are to your financial goals and celebrating small wins. \n\nImagine two people saving for a house. One reviews every month and adjusts, reaching the goal faster, while the other never checks and falls behind.",
            "Regular reviews motivate."
        ),
        (
            "lesson_obj_i_ch4_t3_3",
            "obj_i_ch4_t3_3",
            "Plan Adjustments",
            "Adjusting plans means changing your budget or goals when life changes — new job, higher expenses, or unexpected events. \n\nImagine two people with savings plans. One adjusts after a salary increase and saves more, while the other keeps the old plan and misses opportunities.",
            "Adapt to life changes."
        ),
        (
            "lesson_obj_i_ch5_t1_1",
            "obj_i_ch5_t1_1",
            "Salary Negotiation",
            "Salary negotiation means confidently asking for a higher salary or better benefits based on your skills, experience, and market rates. \n\nImagine two employees doing the same job well. One researches and negotiates from RWF 450,000 to RWF 580,000, while the other accepts the first offer and earns less.",
            "Advocate for worth."
        ),
        (
            "lesson_obj_i_ch5_t1_2",
            "obj_i_ch5_t1_2",
            "Skill Acquisition",
            "Learning new skills through courses, training, or practice increases your value and opens doors to higher-paying jobs or promotions. \n\nImagine two people in similar jobs. One learns digital marketing and gets promoted with RWF 200,000 more salary, while the other stays with the same skills and same pay.",
            "Invest in self-growth."
        ),
        (
            "lesson_obj_i_ch5_t1_3",
            "obj_i_ch5_t1_3",
            "Career Changes",
            "Changing careers to a higher-paying field or industry can significantly increase your income if you plan the transition carefully. \n\nImagine two people. One moves from retail to IT after training and earns twice as much, while the other stays in a low-growth job for years.",
            "Bold steps for income jumps."
        ),
        (
            "lesson_obj_i_ch5_t2_1",
            "obj_i_ch5_t2_1",
            "Opportunity Identification",
            "Identifying side hustle opportunities means looking for needs in your community that match your skills, time, and small capital. \n\nImagine two people with free evenings. One starts phone repair and earns RWF 150,000 extra monthly, while the other never looks for opportunities.",
            "Leverage strengths."
        ),
        (
            "lesson_obj_i_ch5_t2_2",
            "obj_i_ch5_t2_2",
            "Starting Small",
            "Starting a side hustle small with little money reduces risk and lets you test the idea before investing more. \n\nImagine two people. One begins selling vegetables with RWF 80,000 capital and grows slowly, while the other tries to start big with no experience and loses money.",
            "Low risk entry."
        ),
        (
            "lesson_obj_i_ch5_t2_3",
            "obj_i_ch5_t2_3",
            "Scaling Up",
            "Scaling up means reinvesting profits to grow your side hustle — hiring help, buying more stock, or opening a small shop. \n\nImagine two successful hustles. One reinvests profits and grows from home-based to a small boutique, while the other spends all earnings and stays small.",
            "Growth through reinvestment."
        ),
        (
            "lesson_obj_i_ch5_t3_1",
            "obj_i_ch5_t3_1",
            "Income Tracking",
            "Tracking multiple incomes separately helps you see which sources are most profitable and manage taxes more easily. \n\nImagine two people with main job + side hustle. One keeps separate records and knows exactly how much each brings, while the other mixes everything and loses track.",
            "Organization aids management."
        ),
        (
            "lesson_obj_i_ch5_t3_2",
            "obj_i_ch5_t3_2",
            "Tax Management",
            "Proper tax management means declaring all income sources to RRA and keeping good records to avoid penalties and surprises. \n\nImagine two side hustlers earning extra RWF 300,000 monthly. One declares and pays small tax, while the other hides it and later faces big fines.",
            "Compliance is essential."
        ),
        (
            "lesson_obj_i_ch5_t3_3",
            "obj_i_ch5_t3_3",
            "Time Balancing",
            "Balancing time between main job, side hustle, family, and rest prevents burnout and keeps all income streams sustainable. \n\nImagine two people with side businesses. One schedules carefully and stays healthy and productive, while the other overworks, gets tired, and eventually gives up.",
            "Sustainability over burnout."
        ),
        // Advanced
        (
            "lesson_obj_a_ch1_t1_1",
            "obj_a_ch1_t1_1",
            "What Investing Really Means",
            "Investing is putting your money into assets like businesses, property or funds with the expectation that it will grow over time or generate income. Unlike saving, investing involves some risk but offers potential for much higher returns. \n\nImagine two people with RWF 2,000,000 extra cash. One keeps it in a savings account earning 6% interest, while the other invests in quality stocks and property — after 10 years, the investor has significantly more wealth.",
            "Investing grows wealth over the long term."
        ),
        (
            "lesson_obj_a_ch1_t1_2",
            "obj_a_ch1_t1_2",
            "Sources of Investment Returns",
            "You earn returns from investments through price appreciation (assets becoming more valuable), dividends (company profit sharing), interest (from bonds), or rental income (from property). \n\nImagine two investors starting with RWF 3,000,000. One only gets price growth, while the other chooses dividend-paying stocks and rental property — the second person receives regular cash flow even when prices stay flat.",
            "Multiple ways to earn from your money."
        ),
        (
            "lesson_obj_a_ch1_t1_3",
            "obj_a_ch1_t1_3",
            "Investing vs Pure Saving",
            "Saving keeps money safe and available but earns low returns, while investing accepts some risk of loss for the chance of much higher long-term growth. \n\nImagine two people saving for retirement. One puts everything in a bank account, while the other invests wisely — after 25 years, the investor has 3–5 times more money despite market ups and downs.",
            "Investing beats saving for long-term goals."
        ),
        (
            "lesson_obj_a_ch1_t2_1",
            "obj_a_ch1_t2_1",
            "Understanding Stocks",
            "When you buy stocks, you become part owner of a company and benefit when the business grows through rising share prices and possible dividend payments. \n\nImagine two people investing RWF 1,500,000. One buys shares in growing Rwandan companies, while the other keeps the money in savings — after 12 years, the stock investor has several times more capital.",
            "Stocks offer ownership in growing businesses."
        ),
        (
            "lesson_obj_a_ch1_t2_2",
            "obj_a_ch1_t2_2",
            "Understanding Bonds",
            "Bonds are loans you give to governments or companies in exchange for regular interest payments and your principal back at maturity. \n\nImagine two investors with RWF 4,000,000. One buys government treasury bonds and receives predictable interest every six months, while the other tries to time the stock market and experiences big ups and downs.",
            "Bonds provide more predictable income."
        ),
        (
            "lesson_obj_a_ch1_t2_3",
            "obj_a_ch1_t2_3",
            "Other Important Asset Classes",
            "Real estate generates rental income and potential appreciation, while mutual funds and ETFs give you instant diversification across many investments. \n\nImagine two people with RWF 5,000,000. One buys a small rental house in Kigali, while the other puts everything in one company stock — the real estate investor enjoys steady income and less stress.",
            "Different assets serve different purposes."
        ),
        (
            "lesson_obj_a_ch1_t3_1",
            "obj_a_ch1_t3_1",
            "The Power of Time",
            "The longer your money stays invested, the more time it has to grow through compounding and recover from market downturns. \n\nImagine two people investing RWF 500,000 monthly. One starts at age 25, the other at age 35 — even though the second invests the same amount, the first ends up with nearly double the money by age 65.",
            "Time is your greatest investment advantage."
        ),
        (
            "lesson_obj_a_ch1_t3_2",
            "obj_a_ch1_t3_2",
            "Risk and Reward Connection",
            "Generally, investments with higher potential returns come with higher chances of short-term losses — there is no high return without risk. \n\nImagine two investors with RWF 8,000,000. One chooses very safe treasury bonds, while the other invests in growing companies — over 20 years, the risk-taker earns much more, despite some difficult years.",
            "Higher reward requires accepting more risk."
        ),
        (
            "lesson_obj_a_ch1_t3_3",
            "obj_a_ch1_t3_3",
            "Goal-Based Investing",
            "Every investment decision should connect to a clear purpose — retirement, children's education, house purchase, or financial freedom. \n\nImagine two investors. One invests randomly without clear goals, while the other carefully matches investments to specific timelines and needs — the goal-oriented investor achieves objectives faster.",
            "Clear goals guide better decisions."
        ),
        (
            "lesson_obj_a_ch2_t1_1",
            "obj_a_ch2_t1_1",
            "Different Types of Risk",
            "Investments face many risks: market prices can fall, inflation can reduce purchasing power, interest rates can change, and individual companies can struggle. \n\nImagine two portfolios worth RWF 10,000,000. One has only Rwandan bank stocks, while the other is diversified across countries and asset types — when local markets drop, the diversified portfolio loses much less.",
            "Understanding risk is essential for protection."
        ),
        (
            "lesson_obj_a_ch2_t1_2",
            "obj_a_ch2_t1_2",
            "Measuring Investment Risk",
            "Investment risk can be measured through price volatility, how much an asset moves compared to the market (beta), and historical worst-case scenarios. \n\nImagine two investments. One government bond barely moves in price, while a small company stock swings 40% up and down frequently — the stock is clearly riskier but may offer higher long-term returns.",
            "Numbers help quantify risk exposure."
        ),
        (
            "lesson_obj_a_ch2_t1_3",
            "obj_a_ch2_t1_3",
            "Your Personal Risk Tolerance",
            "Your risk tolerance depends on your age, income stability, investment knowledge, and emotional ability to handle market declines. \n\nImagine two investors with the same amount of money. One panics and sells during a 25% market drop, while the other stays calm and even buys more — the calm investor ends up far ahead years later.",
            "Know yourself before choosing investments."
        ),
        (
            "lesson_obj_a_ch2_t2_1",
            "obj_a_ch2_t2_1",
            "Asset Class Diversification",
            "Spreading investments across stocks, bonds, real estate, and cash reduces the impact when any single type of investment performs poorly. \n\nImagine two portfolios of RWF 15,000,000. One is 100% in stocks, while the other is 40% stocks, 30% bonds, 20% real estate, 10% cash — during a stock market crash, the diversified portfolio loses much less.",
            "Diversification protects your wealth."
        ),
        (
            "lesson_obj_a_ch2_t2_2",
            "obj_a_ch2_t2_2",
            "Geographic Diversification",
            "Investing only in Rwanda exposes you to local economic problems — adding international investments reduces country-specific risk. \n\nImagine two investors during an economic slowdown in Rwanda. One has everything in local assets and suffers big losses, while the other has 40% in global funds and experiences much smaller impact.",
            "Don't put all eggs in one country's basket."
        ),
        (
            "lesson_obj_a_ch2_t2_3",
            "obj_a_ch2_t2_3",
            "Regular Rebalancing",
            "Rebalancing means selling assets that have grown a lot and buying those that have fallen to return to your target allocation. \n\nImagine two investors with target 60% stocks, 40% bonds. After a strong stock market year, one rebalances and sells some stocks high, while the other lets stocks grow to 80% — when stocks later fall, the rebalanced investor is much better protected.",
            "Rebalancing enforces discipline."
        ),
        (
            "lesson_obj_a_ch2_t3_1",
            "obj_a_ch2_t3_1",
            "Stop-Loss Protection",
            "Setting automatic sell orders at certain price levels helps limit losses when investments decline significantly. \n\nImagine two investors holding the same stock that drops 35%. One has a 15% stop-loss and sells early limiting damage, while the other hopes it recovers and eventually sells at a 50% loss.",
            "Automatic protection reduces emotional mistakes."
        ),
        (
            "lesson_obj_a_ch2_t3_2",
            "obj_a_ch2_t3_2",
            "Hedging Strategies",
            "Advanced investors use options, inverse funds, or other instruments to protect their portfolio against major market declines. \n\nImagine two investors during a market crash. One has protected part of their portfolio with hedging, losing only 8%, while the unprotected investor loses 35% — hedging saved significant wealth.",
            "Protection tools preserve capital."
        ),
        (
            "lesson_obj_a_ch2_t3_3",
            "obj_a_ch2_t3_3",
            "Emergency Cash Buffer",
            "Keeping 6–24 months of expenses in cash or safe investments prevents you from selling stocks during market lows when you need money urgently. \n\nImagine two people facing a RWF 4,000,000 emergency. One has cash reserves and doesn't touch investments, while the other sells stocks at the worst possible time — the prepared person preserves long-term wealth.",
            "Cash reserves protect investments."
        ),
        (
            "lesson_obj_a_ch3_t1_1",
            "obj_a_ch3_t1_1",
            "Projecting Retirement Expenses",
            "Estimate how much money you'll need monthly in retirement including housing, food, healthcare, travel, and helping family. \n\nImagine two people planning retirement at 60. One calculates RWF 800,000 monthly need, while the other assumes current spending will stay the same — the careful planner builds a much more realistic and secure plan.",
            "Know your number before you retire."
        ),
        (
            "lesson_obj_a_ch3_t1_2",
            "obj_a_ch3_t1_2",
            "Planning for Inflation",
            "Prices typically rise 4–8% per year — money that supports you today will buy much less in 20–30 years. \n\nImagine two retirees with RWF 600,000 monthly income. One planned for inflation and adjusts withdrawals, while the other didn't — after 15 years, the unprepared person struggles while the planner lives comfortably.",
            "Inflation is the silent retirement thief."
        ),
        (
            "lesson_obj_a_ch3_t1_3",
            "obj_a_ch3_t1_3",
            "Longevity Planning",
            "With increasing life expectancy in Rwanda, plan for 25–35 years of retirement income after leaving work. \n\nImagine two people retiring at 60. One plans only until age 80, while the other prepares for living to 95 — the longer-planning person doesn't run out of money in their 80s.",
            "Plan for a long retirement."
        ),
        (
            "lesson_obj_a_ch3_t2_1",
            "obj_a_ch3_t2_1",
            "RSSB Pension Benefits",
            "The Rwanda Social Security Board provides pension benefits for formal sector workers based on contributions made during working years. \n\nImagine two workers with similar careers. One contributes fully to RSSB every month, while the other misses some payments — the consistent contributor receives significantly higher monthly pension.",
            "Maximize mandatory pension contributions."
        ),
        (
            "lesson_obj_a_ch3_t2_2",
            "obj_a_ch3_t2_2",
            "Voluntary Retirement Savings",
            "Personal pension schemes and retirement investment accounts allow additional tax-advantaged savings beyond RSSB. \n\nImagine two professionals earning RWF 1,200,000 monthly. One saves extra RWF 100,000 monthly in a retirement account, while the other spends it — after 25 years, the saver has millions more for retirement.",
            "Extra savings create real security."
        ),
        (
            "lesson_obj_a_ch3_t2_3",
            "obj_a_ch3_t2_3",
            "Annuity Options",
            "Annuities convert a lump sum into guaranteed regular payments for life or a set period. \n\nImagine two retirees with RWF 50,000,000 each. One buys an annuity and receives RWF 350,000 monthly for life, while the other manages investments themselves — the annuity provides peace of mind and predictable income.",
            "Annuities offer lifetime income security."
        ),
        (
            "lesson_obj_a_ch3_t3_1",
            "obj_a_ch3_t3_1",
            "Safe Withdrawal Rates",
            "The 4% rule suggests withdrawing 4% of your portfolio in the first year of retirement, then adjusting for inflation annually. \n\nImagine two retirees with RWF 100,000,000 portfolios. One follows the 4% rule (RWF 4,000,000/year), while the other withdraws 7% — the conservative withdrawer’s money lasts much longer.",
            "Sustainable withdrawals protect your future."
        ),
        (
            "lesson_obj_a_ch3_t3_2",
            "obj_a_ch3_t3_2",
            "Sequence of Returns Risk",
            "Poor investment returns in the first few years of retirement can dramatically reduce how long your savings last. \n\nImagine two people retiring with identical portfolios. One retires just before a market crash, while the other retires after good years — the unlucky timing forces the first to withdraw more shares at low prices, risking running out of money.",
            "Early retirement years are critical."
        ),
        (
            "lesson_obj_a_ch3_t3_3",
            "obj_a_ch3_t3_3",
            "Flexible Spending Strategies",
            "Adjusting withdrawals higher in good market years and lower in bad years helps your portfolio last longer. \n\nImagine two retirees during market ups and downs. One keeps fixed withdrawals, while the other spends less during downturns — the flexible spender preserves capital and maintains lifestyle longer.",
            "Flexibility extends portfolio life."
        ),
        (
            "lesson_obj_a_ch4_t1_1",
            "obj_a_ch4_t1_1",
            "How Compounding Works",
            "Compound growth means your investment earnings generate additional earnings, creating exponential growth over long periods. \n\nImagine investing RWF 1,000,000 at age 25 with 10% average return. By age 65, it grows to over RWF 45,000,000 — most of the wealth came from compounding, not the original amount.",
            "Compounding turns small sums into wealth."
        ),
        (
            "lesson_obj_a_ch4_t1_2",
            "obj_a_ch4_t1_2",
            "The Advantage of Starting Early",
            "The earlier you begin investing, the more time compounding has to work, dramatically increasing final wealth. \n\nImagine two people investing RWF 200,000 monthly. One starts at 25, the other at 35 — even though the second invests for 10 fewer years, the first ends up with nearly twice as much by age 65.",
            "Start today — time is irreplaceable."
        ),
        (
            "lesson_obj_a_ch4_t1_3",
            "obj_a_ch4_t1_3",
            "Reinvesting Returns",
            "Reinvesting dividends and interest instead of spending them supercharges the compounding effect over decades. \n\nImagine two investors with the same stock portfolio. One reinvests all dividends, while the other spends them — after 20 years, the reinvesting investor has significantly more capital and higher future income.",
            "Let your earnings earn more earnings."
        ),
        (
            "lesson_obj_a_ch4_t2_1",
            "obj_a_ch4_t2_1",
            "Age-Appropriate Allocation",
            "Younger investors can hold more stocks for growth, while those near retirement shift toward bonds for stability. \n\nImagine two investors. One is 30 and holds 80% stocks, while the other is 58 and holds 35% stocks — when markets drop, the older investor experiences much less stress and loss.",
            "Match allocation to life stage."
        ),
        (
            "lesson_obj_a_ch4_t2_2",
            "obj_a_ch4_t2_2",
            "Target-Date Funds Approach",
            "Target-date funds automatically shift from aggressive to conservative investments as your retirement date approaches. \n\nImagine two busy professionals. One manually adjusts investments every year, while the other uses a target-date fund — the automatic approach saves time and prevents emotional mistakes.",
            "Set-it-and-forget-it simplicity."
        ),
        (
            "lesson_obj_a_ch4_t2_3",
            "obj_a_ch4_t2_3",
            "Tax-Efficient Investing",
            "Placing high-tax investments in tax-advantaged accounts and tax-efficient investments in regular accounts minimizes tax drag. \n\nImagine two investors with similar portfolios. One optimizes for taxes, while the other doesn't — over 25 years, the tax-smart investor keeps significantly more of their returns.",
            "Keep more by paying less tax."
        ),
        (
            "lesson_obj_a_ch4_t3_1",
            "obj_a_ch4_t3_1",
            "Value Investing Philosophy",
            "Value investing means buying quality assets when they are temporarily underpriced relative to their fundamental worth. \n\nImagine two stock investors. One buys popular expensive stocks, while the other patiently waits for quality companies at bargain prices — over decades, the value investor achieves better returns.",
            "Buy quality when others are fearful."
        ),
        (
            "lesson_obj_a_ch4_t3_2",
            "obj_a_ch4_t3_2",
            "Dividend Growth Strategy",
            "Investing in companies that consistently increase dividends provides growing income and usually more stable returns. \n\nImagine two income-focused investors. One buys high-yield but risky stocks, while the other chooses companies with 10+ years of dividend increases — the dividend growth investor enjoys rising income with less stress.",
            "Growing income with growing stability."
        ),
        (
            "lesson_obj_a_ch4_t3_3",
            "obj_a_ch4_t3_3",
            "Passive vs Active Debate",
            "Low-cost index funds that passively track markets often outperform most actively managed funds over long periods after fees. \n\nImagine two investors with RWF 20,000,000. One pays high fees for active management, while the other uses low-cost index funds — after 20 years, the index investor has significantly more money.",
            "Simple often beats complicated."
        ),
        (
            "lesson_obj_a_ch5_t1_1",
            "obj_a_ch5_t1_1",
            "Your Financial Independence Number",
            "Your FI number is typically 25–33 times your annual expenses — the amount needed to live without working. \n\nImagine two people wanting financial independence. One calculates needing RWF 750,000,000 (25× RWF 30M/year), while the other never figures out the target — the clear-number person reaches independence years earlier.",
            "Know your number, then build toward it."
        ),
        (
            "lesson_obj_a_ch5_t1_2",
            "obj_a_ch5_t1_2",
            "Power of High Savings Rate",
            "Saving 50–70% of income dramatically shortens the time needed to reach financial independence. \n\nImagine two people earning RWF 1,500,000 monthly. One saves 60% (RWF 900,000), while the other saves 20% — the high saver reaches financial independence in about 12 years, while the low saver takes 30+ years.",
            "Savings rate determines speed."
        ),
        (
            "lesson_obj_a_ch5_t1_3",
            "obj_a_ch5_t1_3",
            "Multiple Income Streams",
            "Creating several reliable income sources reduces risk and accelerates wealth building. \n\nImagine two people pursuing financial freedom. One depends only on salary, while the other builds salary + rental income + dividends + side business — when the job market weakens, the diversified person stays financially secure.",
            "Diversified income = greater security."
        ),
        (
            "lesson_obj_a_ch5_t2_1",
            "obj_a_ch5_t2_1",
            "Importance of a Will",
            "A will legally directs how your assets should be distributed after your death, preventing family disputes and government decisions. \n\nImagine two families after losing the main breadwinner. One had a clear will and assets transferred smoothly, while the other had no will — the family with a will avoids years of conflict and legal costs.",
            "A will protects your loved ones."
        ),
        (
            "lesson_obj_a_ch5_t2_2",
            "obj_a_ch5_t2_2",
            "Using Trusts Strategically",
            "Trusts can control how and when heirs receive assets, offer tax advantages, and protect wealth from creditors or poor decisions. \n\nImagine two wealthy parents. One uses trusts to provide controlled distributions to children, while the other gives everything outright — the trust approach prevents irresponsible spending and protects the legacy.",
            "Trusts provide more control."
        ),
        (
            "lesson_obj_a_ch5_t2_3",
            "obj_a_ch5_t2_3",
            "Beneficiary Designations",
            "Updating beneficiaries on bank accounts, insurance, and investment accounts ensures assets go directly to the intended people quickly. \n\nImagine two people who divorced years ago. One updated beneficiaries after divorce, while the other forgot — the updated person’s assets went to current family, while the outdated designation created major problems.",
            "Keep beneficiaries current."
        ),
        (
            "lesson_obj_a_ch5_t3_1",
            "obj_a_ch5_t3_1",
            "Teaching Financial Literacy",
            "Passing financial knowledge to children and grandchildren helps them build and protect wealth for generations. \n\nImagine two wealthy grandparents. One teaches budgeting, investing, and delayed gratification to grandchildren, while the other just gives money — the educated grandchildren build their own wealth, while the others struggle despite inheritance.",
            "Knowledge is the best legacy."
        ),
        (
            "lesson_obj_a_ch5_t3_2",
            "obj_a_ch5_t3_2",
            "Strategic Lifetime Gifting",
            "Giving assets while alive can reduce estate taxes, help family when they need it most, and allow you to see the impact. \n\nImagine two wealthy parents. One waits until death to pass assets, while the other strategically gifts during life for education and home purchases — the gifting parents see their children succeed and build stronger family bonds.",
            "Giving while living creates impact."
        ),
        (
            "lesson_obj_a_ch5_t3_3",
            "obj_a_ch5_t3_3",
            "Creating Philanthropic Legacy",
            "Establishing charitable giving, foundations, or scholarships creates positive impact that continues beyond your lifetime. \n\nImagine two successful business owners. One focuses only on family wealth, while the other creates a foundation for education in Rwanda — decades later, the foundation continues helping thousands while family wealth alone fades.",
            "Legacy extends beyond money."
        )
    ]
}
