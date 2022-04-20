using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Calculator
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        double lastNumber, result;
        SelectedOperator selectedOperator;

        public MainWindow()
        {
            InitializeComponent();

            btn_ac.Click += Btn_ac_Click;
            btn_negative.Click += Btn_negative_Click;
            btn_percentage.Click += Btn_percentage_Click;
            btn_equals.Click += Btn_equals_Click;
        }

        private void Btn_equals_Click(object sender, RoutedEventArgs e)
        {
            double newNumber;

            if (double.TryParse(lbl_result.Content.ToString(), out newNumber))
            {
                switch (selectedOperator)
                {
                    case SelectedOperator.Addition:
                        result = SimpleMath.Add(lastNumber, newNumber);
                        break;
                    case SelectedOperator.Substraction:
                        result = SimpleMath.Subtraction(lastNumber, newNumber);
                        break;
                    case SelectedOperator.Multiplication:
                        result = SimpleMath.Multiplication(lastNumber, newNumber);
                        break;
                    case SelectedOperator.Division:
                        result = SimpleMath.Division(lastNumber, newNumber);
                        break;
                }
            }

            lbl_result.Content = result.ToString();
        }

        private void Btn_percentage_Click(object sender, RoutedEventArgs e)
        {
            double tempNumber;

            if (double.TryParse(lbl_result.Content.ToString(), out tempNumber))
            {
                tempNumber = (tempNumber / 100);
                if (lastNumber != 0)
                {
                    tempNumber = lastNumber * tempNumber;
                }

                lbl_result.Content = tempNumber.ToString();
            }
        }

        private void Btn_negative_Click(object sender, RoutedEventArgs e)
        {
            if (double.TryParse(lbl_result.Content.ToString(), out lastNumber))
            {
                lastNumber = lastNumber * -1;
                lbl_result.Content = lastNumber.ToString();
            }

        }

        private void btn_dot_Click(object sender, RoutedEventArgs e)
        {
            if (lbl_result.Content.ToString().Contains("."))
            {
                //Do nothing
            }
            else
            {
                lbl_result.Content = $"{lbl_result.Content}.";
            }
        }

        private void Btn_ac_Click(object sender, RoutedEventArgs e)
        {
            lbl_result.Content = "0";
            lastNumber = 0;
            result = 0;
        }

        private void numberButton_Click(object sender, RoutedEventArgs e)
        {
            int selectedValue = int.Parse((sender as Button).Content.ToString());

            if (lbl_result.Content.ToString() == "0")
            {
                lbl_result.Content = $"{selectedValue}";
            }
            else
            {
                lbl_result.Content = $"{lbl_result.Content}{selectedValue}";
            }
        }

        private void operationButton_click(object sender, RoutedEventArgs e)
        {
            if (sender == btn_devision)
            {
                selectedOperator = SelectedOperator.Division;
            }
            else if (sender == btn_multipication)
            {
                selectedOperator = SelectedOperator.Multiplication;
            }
            else if (sender == btn_substraction)
            {
                selectedOperator = SelectedOperator.Substraction;
            }
            else if (sender == btn_addition)
            {
                selectedOperator = SelectedOperator.Addition;
            }
            
            if (double.TryParse(lbl_result.Content.ToString(), out lastNumber))
            {
                lbl_result.Content = "0";
            }
        }
    }

    public enum SelectedOperator
    {
        Addition,
        Substraction,
        Multiplication,
        Division
    }

    public class SimpleMath
    {
        public static double Add(double n1, double n2)
        {
            return n1 + n2;
        }

        public static double Subtraction(double n1, double n2)
        {
            return n1 - n2;
        }

        public static double Multiplication(double n1, double n2)
        {
            return n1 * n2;
        }

        public static double Division(double n1, double n2)
        {
            if (n2 == 0)
            {
                MessageBox.Show("Division by 0 is not supported", "Wrong operation", MessageBoxButton.OK, MessageBoxImage.Error);
                //We are adding return 0 so the other return is not executed (a method stops executing once it returns something).
                return 0;
            }
            
            return n1 / n2;
        }
    }

}
