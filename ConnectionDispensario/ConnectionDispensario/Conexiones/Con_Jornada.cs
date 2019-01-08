﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectionDispensario.Conexiones
{
    public static class Con_Jornada
    {
        public static void InsertarJornada(int UserId)
        {
            QTACustomizado QTA = new QTACustomizado();
            QTA.InsertarPeriodo_Cronograma_Entrada(UserId, Utils.Conversiones.SQL_To_FullString_DateTime(DateTime.Now)); 
        }

        public static void UpdateJornada(int JornadaId, decimal Horas)
        {
            QTACustomizado QTA = new QTACustomizado();
            QTA.InsertarPeriodo_Cronograma_Salida(JornadaId, Utils.Conversiones.SQL_To_FullString_DateTime(DateTime.Now), Horas);
        }

        public static DataRow GetLastJornada(int UserId)
        {
            DispensarioACDataSet.SeleccionarPeriodo_Cronograma_UltimoDataTable DT = new DispensarioACDataSet.SeleccionarPeriodo_Cronograma_UltimoDataTable();
            DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_UltimoTableAdapter TA = new DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_UltimoTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "mi clase");
            TA.Connection = SQLCONN;
            TA.Fill(DT,UserId);
            if (DT.Rows.Count > 0)
            {
                return DT.Rows[0];
            }
            else
            {
                return null;
            }
        }

        public static DataTable GetPeriodo(DateTime Start, DateTime End, int UserId) 
        {
            DispensarioACDataSet.SeleccionarPeriodo_Cronograma_PeriodoDataTable DT = new DispensarioACDataSet.SeleccionarPeriodo_Cronograma_PeriodoDataTable();
            DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_PeriodoTableAdapter TA = new DispensarioACDataSetTableAdapters.SeleccionarPeriodo_Cronograma_PeriodoTableAdapter();
            System.Data.SqlClient.SqlConnection SQLCONN = TA.Connection;
            Conexiones.TableAdapterManager.ChangeConnection(ref SQLCONN, "mi clase");
            TA.Connection = SQLCONN;
            if (DT.Rows.Count > 0)
            {
                return DT;
            }
            else
            {
                return null;
            }
        }

    }
}