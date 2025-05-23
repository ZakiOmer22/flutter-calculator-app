using System;
using System.Collections.Generic;
using System.Data;
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
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for WpfCalculator.xaml
    /// </summary>
    public partial class WpfCalculator : Window
    {
        private string ans = "";
        public WpfCalculator()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string content = (string)((Button)sender).Content;

            switch (content)
            {
                case "C":
                    InputTextBox.Text = "";
                    ResultTextBlock.Text = "";
                    break;

                case "DEL":
                    if (InputTextBox.Text.Length > 0)
                        InputTextBox.Text = InputTextBox.Text.Substring(0, InputTextBox.Text.Length - 1);
                    break;

                case "=":
                    try
                    {
                        string expr = InputTextBox.Text.Replace("%", "/100");
                        var result = new DataTable().Compute(expr, null);
                        ResultTextBlock.Text = "= " + result.ToString();
                        ans = result.ToString();
                    }
                    catch
                    {
                        ResultTextBlock.Text = "Error";
                    }
                    break;

                case "ANS":
                    InputTextBox.Text += ans;
                    break;

                default:
                    InputTextBox.Text += content;
                    break;
            }
        }
    }
}
