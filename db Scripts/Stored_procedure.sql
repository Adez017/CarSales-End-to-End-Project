Create Procedure updateWaterTbale
@lastload varchar(200)
As
begin
	---start of trnascation
	Begin transaction;
	--updating the incremental column value
	update Water_table
	set last_load = @lastload
	commit transaction;
	End;