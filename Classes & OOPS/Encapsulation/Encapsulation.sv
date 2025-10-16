class BankAccount;

protected int balance;
int acc_num;

  // Constructor: called automatically on new()
function new(int acc=0,initial_balance=0);
acc_num =acc;
balance=initial_balance;
endfunction

//deposit money setter
function void deposit(int amount);
if(amount>0)
	balance+=amount;
else
	$display("%0t : Deposit amount must be positive",$time);
endfunction

//withdraw money setter
function void withdraw(int amount);
if(amount>0 && amount <= balance)
	balance-=amount;
else
	$display("%0t : Withdraw amount must be positive and less than or equal to the balance amount in the account",$time);
endfunction

//current balance getter
function int check_balance();
return balance;
endfunction

//account info display
function void display();
$display("%0t Account_num:%0d   Balance:%0d",$time,acc_num,balance);
endfunction

endclass



module Encaps_tb;

BankAccount b1,b2;

initial begin
b1=new(150,5000);
b2=new(200,75000);
$display("\n--- Initial Accounts ---");
b1.display();
b2.display();

b1.deposit(1800);
b2.withdraw(96000);

$display("\n--- After Transactions ---");
b1.display();
b2.display();

$display("\n--- Accessing balance via getter ---");
$display("Account %0d Balance=%0d", b1.acc_num, b1.check_balance());
$display("Account %0d Balance=%0d", b2.acc_num, b2.check_balance());

  
b2.deposit(-50);   
#10 $finish;

end

endmodule









// ==================================================================================
// Notes / DV-style explanation (to put in source code comments)
// ==================================================================================
//
// 1. Constructor & Object Handles
// - `new(acc_num, balance)` automatically called when object is created.
// - Initializes account number and initial balance.
// - Values in parentheses go only to the constructor, not to other functions like display().
//
// 2. Encapsulation
// - `balance` is protected ? cannot access directly from testbench.
// - Functions inside the class can freely read/write `balance`.
//
// 3. Getter / Setter
// - Setter: `deposit()` and `withdraw()` change protected balance safely.
// - Getter: `get_balance()` returns protected balance to outside code.
// - All access from outside must go through these functions.
//
// 4. DV-style Safety & Checks
// - Deposit must be positive, withdraw cannot exceed balance.
// - Invalid operations generate messages without crashing simulation.
//
// 5. Object Handles & Multiple Objects
// - `acc1 = new(...)` and `acc2 = new(...)` are executed **sequentially**, not concurrently.
// - Each object has its own separate `balance`.
//
// 6. Why new() goes to constructor automatically
// - `new(...)` is a **special function in SystemVerilog** reserved for constructors.
// - Other functions (display(), deposit(), etc.) are not called automatically.
//
// 7. Using display()
// - Can be called anywhere in the class or testbench to show values.
// - Does not interfere with constructor or object initialization.
//
// 8. Professional DV Practice
// - Use getters/setters for protected data
// - Use constructors to initialize object state
// - Keep all checks inside class to avoid external misuse
// - Display meaningful messages for simulation logs
//
// ==================================================================================

