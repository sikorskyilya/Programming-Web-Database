using System.Data.SqlClient;
using System.Data.SqlTypes;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static int GetCostByService(SqlDateTime start, SqlDateTime end)
    {
        int rows;
        SqlConnection conn = new SqlConnection("Context Connection=true");
        conn.Open();

        SqlCommand sqlCmd = conn.CreateCommand();

        sqlCmd.CommandText = @"select  sum([Artem Panas])+ sum([Ilya]) 
                               from Orders PIVOT(sum(idTrip) for Custromer in([Artem Panas],
                               [Ilya])) pvt  where Sdate > @start or  Sdate < '@end";
        sqlCmd.Parameters.AddWithValue("@start", start);
        sqlCmd.Parameters.AddWithValue("@end", end);

        rows = (int)sqlCmd.ExecuteScalar();
        conn.Close();

        return rows;
    }
}