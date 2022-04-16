/*
Copyright © 2022 Mitchell Stanton <mitchell.stanton@cyber76.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package cmd

import (
	"bufio"
	"fmt"
	"os"
	"strings"

	"github.com/spf13/cobra"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "mock",
	Short: "A cool tool to mock your friends",
	Long: `Always wanted a command line tool to mock your friends? 
Tired of having to manually type out "WoW BoB yOuR aMaZinG!" every time?
Well now, you don't need to! With 'mock' you can do this automatically.`,

	Run: func(cmd *cobra.Command, args []string) {
		var textInput string
		var newCharacter string
		var newString string
		var counter int
		if len(args) <= 0 {
			scanner := bufio.NewScanner(os.Stdin)
			fmt.Println("Please provide text to mock.")
			scanner.Scan()
			scannerText := scanner.Text()
			textInput = string(scannerText)
			fmt.Println("---------- Output ----------")

		} else {
			textInput = strings.Join(args, " ")
		}
		splitString := strings.Split(textInput, "")
		counter = 0
		for i := 0; i < len(splitString); i++ {
			currentCharacter := splitString[i]
			if (currentCharacter < "a" || currentCharacter > "z") && (currentCharacter < "A" || currentCharacter > "Z") {
				newCharacter = currentCharacter

			} else {
				if counter%2 == 0 {
					newCharacter = strings.ToUpper(currentCharacter)

				} else {
					newCharacter = strings.ToLower(currentCharacter)
				}
				counter = counter + 1
			}
			newString = newString + newCharacter
		}
		fmt.Println(strings.TrimSpace(newString))

	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	cobra.CheckErr(rootCmd.Execute())
}

func init() {
	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.

	//rootCmd.PersistentFlags().StringVar("help", "h", "Shows help menu")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	//rootCmd.Flags().BoolP("silent", "s", false, "Does not give 'Mock your friends with this' message")
}
