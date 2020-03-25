using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native)]
public struct MoneyType :INullable
{
    private double _myex;
    private bool m_Null;

    public MoneyType(bool isnull)
    {
        m_Null = isnull;
        _myex = 0;
    }

    public MoneyType(double s)
    {
        _myex = s;
        m_Null = false;
    }

    public override string ToString()
    {
        return m_Null ? null : _myex.ToString();
    }

    public bool IsNull
    {
        get
        {
            return m_Null;
        }
    }

    public static  MoneyType Null
    {
        get
        {
            MoneyType h = new MoneyType();
            h.m_Null = true;
            return h;
        }
    }

    public static MoneyType Parse(SqlString s)
    {
        string value = s.Value.ToString();

        if (s.IsNull || s == "")
            return Null;

        double Num;
        bool isNum = double.TryParse(value, out Num);

        if (!isNum)
        {
            throw new InvalidOperationException("Non numeric charactrs are not permitted");

        }
        double d = double.Parse(value);
        if (d > 140 || d < -140)
            throw new InvalidOperationException("Temperature outside of range");
        MoneyType moneyType = new MoneyType(double.Parse(value));
        return moneyType;

    }
}
