using System;
using System.Collections.Generic;
using System.Text;

namespace Agilis.Engine.Coding.Expressions
{
    public class Expresion
    {
        static string m_szCmprsnRegEx = @"[=<>!]{1,2}"; //Expresion regular para dividir operandos

        private System.Text.RegularExpressions.Regex regExp = new System.Text.RegularExpressions.Regex("("+m_szCmprsnRegEx+")");

        /// <summary>
        /// Clase para evaluar Expresiones comparativas sobre nodos de XML
        /// </summary>
        public Expresion() { }

        /// <summary>
        /// Evalua el contenido de un nodo XML con la expresion de comparacion.
        /// Para referir al nombre de un atributo basta con usar su nombre (ej. atrib1==atrib2).
        /// Para referir a una constante numerica, usar el numero directamente (ej. atrib1==2).
        /// Para referir a una constante de cadena, usar comillas simples para definirla (ej. atrib1=='ejemplo').
        /// </summary>
        /// <param name="node">Nodo XML a evaluar</param>
        /// <param name="Expression">Expresion a evaluar</param>
        /// <returns></returns>
        public bool Evaluate(System.Xml.XmlNode node, string Expression)
        {
            if (Expression == null || Expression == "") return true;
            if (node == null) return false;

            string[] Parts = this.SplitExpression(Expression);
            if (Parts.Length != 3)
            {
                throw new Exception("Agilis.Engine.Coding.Expressions: Solo expresiones de 2 Operandos y un Operador son soportados.");
            }
            IOperand firstOperand = this.CreateOperand(node, Parts[0]);
            IOperand secondOperand = this.CreateOperand(node, Parts[2]);
            Operator op = new Operator(Parts[1]);
            return op.Eval(firstOperand,secondOperand);
        }

        private string[] SplitExpression(string pExpression)
        {
            return regExp.Split(pExpression);
        }

        private IOperand CreateOperand(System.Xml.XmlNode node,string value)
        {
            try
            {
                try
                {
                    float.Parse(value, System.Globalization.CultureInfo.InvariantCulture);
                }
                catch
                {
                    float.Parse(node.Attributes.GetNamedItem(value).Value, System.Globalization.CultureInfo.InvariantCulture);
                }

                return new Operand_Numeric(node, value);
            }
            catch
            {
                return new Operand_String(node, value);
            }
        }
    }

    internal class Operator
    {
        private string _Operator;

        public Operator(string sOperator)
        {
            this._Operator = sOperator;
        }

        public bool Eval(IOperand first, IOperand second)
        {
            switch (this._Operator)
            {
                case "==":
                    return ((IOperations)first).EqualTo(second);
                case "!=":
                    return ((IOperations)first).NotEqualTo(second);
                case "<":
                    return ((IOperations)first).LessThan(second);
                case "<=":
                    return ((IOperations)first).LessThanOrEqualTo(second);
                case ">":
                    return ((IOperations)first).GreaterThan(second);
                case ">=":
                    return ((IOperations)first).GreaterThanOrEqualTo(second);
            }
            return false;
        }
    }

    #region Operandos
    
    internal class Operand_Numeric : IOperand, IOperations
    {
        private float _Value;
        public float Value
        {
            get
            {
                return this._Value;
            }
        }
        /// <summary>
        /// Operando de Tipo Numerico
        /// </summary>
        /// <param name="node">Nodo XML a evaluar</param>
        /// <param name="pValue">Token con el valor del Operando</param>
        public Operand_Numeric(System.Xml.XmlNode node, string pValue)
        {
            try
            {
                this._Value = float.Parse(pValue, System.Globalization.CultureInfo.InvariantCulture);
            }
            catch
            {
                this._Value = float.Parse(node.Attributes.GetNamedItem(pValue).Value, System.Globalization.CultureInfo.InvariantCulture);
            }
        }

        public bool EqualTo(IOperand rhs)
        {
            if (!(rhs is Operand_Numeric))
                return false;
            return this._Value.Equals(((Operand_Numeric)rhs).Value);
        }
        public bool NotEqualTo(IOperand rhs)
        {
            if (!(rhs is Operand_Numeric))
                return false;
            return !this._Value.Equals(((Operand_Numeric)rhs).Value);
        }
        public bool LessThan(IOperand rhs)
        {
            if (!(rhs is Operand_Numeric))
                return false;
            return this._Value < ((Operand_Numeric)rhs).Value;
        }
        public bool LessThanOrEqualTo(IOperand rhs)
        {
            if (!(rhs is Operand_Numeric))
                return false;
            return this._Value <= ((Operand_Numeric)rhs).Value;
        }
        public bool GreaterThan(IOperand rhs)
        {
            if (!(rhs is Operand_Numeric))
                return false;
            return this._Value > ((Operand_Numeric)rhs).Value;
        }
        public bool GreaterThanOrEqualTo(IOperand rhs)
        {
            if (!(rhs is Operand_Numeric))
                return false;
            return this._Value >= ((Operand_Numeric)rhs).Value;
        }
    }

    internal class Operand_String : IOperand, IOperations
    {
        private string _Value;
        public string Value
        {
            get
            {
                return this._Value;
            }
        }

        /// <summary>
        /// Operando del Tipo Cadena
        /// </summary>
        /// <param name="node">Nodo XML a evaluar</param>
        /// <param name="pValue">Token con el valor del Operando</param>
        public Operand_String(System.Xml.XmlNode node, string pValue)
        {
            if (pValue.IndexOf("'") > -1)
                this._Value = pValue.Replace("'","");
            else
                try
                {
                    this._Value = node.Attributes.GetNamedItem(pValue).Value;
                }
                catch
                {
                    this._Value = "";
                }
        }

        public bool EqualTo(IOperand rhs)
        {
            if (!(rhs is Operand_String))
                return false;
            return this._Value.Equals(((Operand_String)rhs).Value);
        }
        public bool NotEqualTo(IOperand rhs)
        {
            if (!(rhs is Operand_String))
                return false;
            return !this._Value.Equals(((Operand_String)rhs).Value);
        }
        public bool LessThan(IOperand rhs)
        {
            return false;
        }
        public bool LessThanOrEqualTo(IOperand rhs)
        {
            return false;
        }
        public bool GreaterThan(IOperand rhs)
        {
            return false;
        }
        public bool GreaterThanOrEqualTo(IOperand rhs)
        {
            return false;
        }
    } 
    #endregion

    #region Interfaces
    //Interfaz para homogeneizar referencias a Operandos
    internal interface IOperand { };
    //Interfaz para homogeneizar referencias a operaciones de Operandos
    internal interface IOperations
    {
        bool EqualTo(IOperand rhs);
        bool NotEqualTo(IOperand rhs);
        bool LessThan(IOperand rhs);
        bool LessThanOrEqualTo(IOperand rhs);
        bool GreaterThan(IOperand rhs);
        bool GreaterThanOrEqualTo(IOperand rhs);
    } 
    #endregion

    
}
