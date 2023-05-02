class CourseraBank {
    var name = ""
    var accountType = ""
    var isOpened = true
    func welcomeCustomer(_ name: String) {
        print("Hello \(name), Welcome to Coursera Bank.")
    }
    func giveCustomerCreatingAccountOptions() {
        print("""
        What kind of bank account would you like to open?
        1. Debit Account,
        2. Credit Account
        """)
    }
    func createAccount(randomNumber: Int) {
        print("You have selected Option \(randomNumber)")
        switch randomNumber {
            case 1: accountType = "debit"
            case 2: accountType = "credit"
            default: print("Invalid Input: \(randomNumber)")
            return
        }
        print("You have created a \(accountType) account.")
    }
    func transferMoney (
        transferType: String,
        transferAmount: Int,
        bankAccount: inout BankAccount
    ) {
        switch transferType {
        case "withdraw":
            if accountType == "credit" {
                bankAccount.withdrawCredit(transferAmount)
            } else if accountType == "debit" {
                bankAccount.withdrawDebit(transferAmount)
            }
        case "deposit":
            if accountType == "credit" {
                bankAccount.depositCredit(transferAmount)
            } else if accountType == "debit" {
                bankAccount.depositDebit(transferAmount)
            }
        default:
            break
        }
    }
    func checkBalance (bankAccount: BankAccount) {
        switch accountType {
        case "credit": print(bankAccount.creditBalanceInfo)
        case "debit": print(bankAccount.debitBalanceInfo)
        default: break
        }
    }
}

struct BankAccount {
    var debitBalance = 0
    var creditBalance = 0
    var creditLimit = 100
    var debitBalanceInfo: String {
        "Debit balance: $\(debitBalance)"
    }
    var availableCredit: Int {
        creditBalance + creditLimit
    }
    var creditBalanceInfo: String {
        "Available Credit: $\(availableCredit)"
    }
    mutating func depositDebit(_ amount: Int) {
        debitBalance += amount
        print("Debit deposited: $\(amount). \(debitBalanceInfo)")
    }
    mutating func withdrawDebit(_ amount: Int) {
        if amount > debitBalance {
            print("Insufficient amount to withdraw $\(amount). \(debitBalanceInfo)")
        } else {
            debitBalance -= amount
            print("Debit withdrawal: $\(amount). \(debitBalanceInfo)")
        }
    }
    mutating func withdrawCredit(_ amount: Int) {
        if amount > creditLimit {
            print("Insufficient credit limit to withdraw $\(amount). \(creditBalanceInfo)")
        } else {
            creditBalance -= amount
            print("Credit withdrawal: $\(amount). \(creditBalanceInfo)")
        }
    }
    mutating func depositCredit(_ amount: Int) {
        creditBalance += amount
        print("Credit deposited: $\(amount). \(creditBalanceInfo)")
        if creditBalance == 0 {
            print("Paid off credit balance.")
        } else if creditBalance > 0 {
            print("Overpaid credit balance.")
        }
    }
}

let courseraBank = CourseraBank()
courseraBank.welcomeCustomer("Rıdvan")

repeat {
    courseraBank.giveCustomerCreatingAccountOptions()
    let randomNumber = Int.random(in: 1...3)
    courseraBank.createAccount(randomNumber: randomNumber)
} while courseraBank.accountType == ""

let transferAmount = 50
print("Transfer amount: $\(transferAmount)")
var bankAccount = BankAccount()

repeat {
    print("""
    What would you like to do?
    1. Check account balance
    2. Withdraw money
    3. Deposit money
    4. Close the system
    """)
    let random = Int.random(in: 1...5)
    print("You have selected option \(random).")
    switch random {
    case 1:courseraBank.checkBalance(bankAccount: bankAccount)
    case 2:courseraBank.transferMoney(transferType: "withdraw", transferAmount: transferAmount, bankAccount: &bankAccount)
    case 3:courseraBank.transferMoney(transferType: "deposit", transferAmount: transferAmount, bankAccount: &bankAccount)
    case 4:courseraBank.isOpened = false
           print("The system is closed.")
    default: break
    }
} while courseraBank.isOpened
