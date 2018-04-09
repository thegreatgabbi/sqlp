-- Question 1
CREATE PROCEDURE Procedure1
AS
BEGIN
	SELECT *
	WHERE Category = 'A'
END

-- Question 2
CREATE PROCEDURE Procedure2(@category varchar(50))
AS
	SELECT *
	WHERE Category = @category
BEGIN

-- What is the output if the argument is 'B'?
Exec Procedure2 'B'

-- What is the output if the argument is 'Z'?
Exec Procedure2 @category='Z'