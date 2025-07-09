# Business Central Developer Practical Test

## Getting Started

### Prerequisites
- Microsoft Dynamics 365 Business Central version 24.0.0.0

### Installation
1. **Clone the Repository**
   ```bash
   git clone https://github.com/Denisnjeru/Business_Central_Practical_Test.git
   cd Business_Central_Practical_Test

2. Add a launch json and specify the instance of business central 24.0.0.0 running locally on your machine.

3. Change the port to refer to the one currently tied to the version of business central running locally on your machine.

4. Use (Ctrl + Shift + P) command to publish the project locally


### Alternatively use the (Ctrl + Shift + B) command to build the app (an .app file) that can be used to publish the application directly on the powershell



### Project Structure

1. **.gitignore** 
List of blobs for git to ignore. Affects commands like git add and git clean. You may use gitignore.io to generate a clean and useful gitignore file.

2. **.alpackages/**
Folder in a Business Central project functions as a local repository for extension packages (.app files) that your project depends on, including Microsoft base extensions, third-party extensions, and your own referenced extensions. This critical directory enables the AL compiler to resolve symbol definitions from dependencies, providing IntelliSense support and ensuring proper code compilation during development.

### Summary of what was done 
1. Extended the Sales Header table by adding two new fields.

2. Extended the Sales Header page to display the new fields only when Document Type = Order.

3. Added validation on the Post action to prevent posting if:

   Delivery Method = Courier

   Document Type = Order

4. Added the same validation using event subscribers on:

   OnBeforeConfirmPost

   OnBeforeConfirmPostAndSend

5. Created a Delivery Instruction Log table to record changes.

Hooked into the OnModify trigger on the Sales Header to:

Check if the Delivery Instruction field is modified.

Log the change into the Delivery Instruction Log table.



### Steps on Testing
On the Role Center

1. Includes a Sales Order list to quickly create and test new orders.

2. Delivery Instruction Log

A page below the Sales Order list shows logs of all changes made to the Delivery Instruction field.