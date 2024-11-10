**English Document**

**Program to Find the Largest Digit of a Number**

This program takes a number as input and finds the largest digit of that number. It uses a loop to divide the number by 10 and keep track of the remainder, which is the last digit of the number. The largest digit is stored in the `d` variable.

**Breakdown of the Code**

1. The program starts by initializing the `DS` register with the address of the data segment.
2. The `input_num` procedure is called to read a number from the keyboard and store it in the `ax` register.
3. The `maghlob` procedure is called to find the largest digit of the number. This procedure uses a loop to divide the number by 10 and keep track of the remainder.
4. The largest digit is stored in the `d` variable.
5. The program then prints the largest digit using the `print_num` procedure.

**Notes and Comments**

* The program uses the `CWD` instruction to convert the number to a double word before dividing it by 10.
* The `DIV` instruction is used to divide the number by 10 and get the remainder.
* The `MUL` instruction is used to multiply the remainder by 10 and add it to the previous result.

**Suggestions for Improvement**

* The program can be improved by adding error handling for invalid inputs.
* The program can be optimized by using a more efficient algorithm to find the largest digit.

**Name:** `largest_digit.asm`

**فارسی**

برنامه‌ای برای یافتن بزرگترین رقم یک عدد

این برنامه عددی را به عنوان ورودی می‌گیرد و بزرگترین رقم آن عدد را پیدا می‌کند. این برنامه از یک حلقه برای تقسیم عدد بر 10 و نگهداری باقیمانده استفاده می‌کند که آخرین رقم عدد است. بزرگترین رقم در متغیر `d` ذخیره می‌شود.

**تجزیه و تحلیل کد**

1. برنامه با初始化 رجیستر `DS` با آدرس بخش داده شروع می‌شود.
2. روال `input_num` برای خواندن عددی از صفحه کلید و ذخیره آن در رجیستر `ax` فراخوانی می‌شود.
3. روال `maghlob` برای یافتن بزرگترین رقم عدد فراخوانی می‌شود. این روال از یک حلقه برای تقسیم عدد بر 10 و نگهداری باقیمانده استفاده می‌کند.
4. بزرگترین رقم در متغیر `d` ذخیره می‌شود.
5. برنامه سپس بزرگترین رقم را با استفاده از روال `print_num` چاپ می‌کند.

**یادداشت‌ها و نظرات**

* برنامه از دستور `CWD` برای تبدیل عدد به کلمه دوگانه قبل از تقسیم آن بر 10 استفاده می‌کند.
* دستور `DIV` برای تقسیم عدد بر 10 و دریافت باقیمانده استفاده می‌شود.
* دستور `MUL` برای ضرب باقیمانده در 10 و اضافه کردن آن به نتیجه قبلی استفاده می‌شود.

**پیشنهادات برای بهبود**

* برنامه می‌تواند با اضافه کردن مدیریت خطا برای ورودی‌های نامعتبر بهبود یابد.
* برنامه می‌تواند با استفاده از الگوریتم مؤثرتری برای یافتن بزرگترین رقم بهبود یابد.

**نام:** `largest_digit.asm`
==========================================================================================
**English Document**

**Procedure to Read a Number from the Keyboard**

This procedure reads a number from the keyboard and stores it in the `ax` register.

**Breakdown of the Code**

1. The `getstr1` macro is called to read a string from the keyboard and store it in the `buffer` variable.
2. The procedure then initializes the `ax` register to 0 and the `si` register to 2.
3. The procedure then loops through the characters in the `buffer` variable, starting from the second character (index 2).
4. For each character, the procedure subtracts 48 from the ASCII value of the character to get the decimal value of the digit.
5. The procedure then multiplies the decimal value by 10 and adds it to the `ax` register.
6. The procedure repeats steps 4 and 5 until it reaches the end of the string.

**Notes and Comments**

* The `getstr1` macro is used to read a string from the keyboard and store it in the `buffer` variable.
* The procedure uses the `CWD` instruction to convert the number to a double word before dividing it by 10.
* The procedure uses the `MUL` instruction to multiply the decimal value by 10 and add it to the `ax` register.

**Suggestions for Improvement**

* The procedure can be improved by adding error handling for invalid inputs.
* The procedure can be optimized by using a more efficient algorithm to convert the string to a number.

** Name:** `read_number.asm`

**فارسی**

روال خواندن یک عدد از صفحه کلید

این روال عددی را از صفحه کلید می‌خواند و آن را در رجیستر `ax` ذخیره می‌کند.

**تجزیه و تحلیل کد**

1. ماکرو `getstr1` برای خواندن یک رشته از صفحه کلید و ذخیره آن در متغیر `buffer` فراخوانی می‌شود.
2. روال سپس رجیستر `ax` را به 0 و رجیستر `si` را به 2初始化 می‌کند.
3. روال سپس حلقه‌ای را از طریق کاراکترهای در متغیر `buffer` تشکیل می‌دهد، شروع از دومین کاراکتر (شاخص 2).
4. برای هر کاراکتر، روال 48 را از مقدار ASCII کاراکتر می‌زباند تا مقدار دسیمالی رقم را بدست آورد.
5. روال سپس مقدار دسیمالی را در 10 ضرب می‌کند و آن را به رجیستر `ax` اضافه می‌کند.
6. روال مراحل 4 و 5 را تکرار می‌کند تا به انتهای رشته برسد.

**یادداشت‌ها و نظرات**

* ماکرو `getstr1` برای خواندن یک رشته از صفحه کلید و ذخیره آن در متغیر `buffer` استفاده می‌شود.
* روال از دستور `CWD` برای تبدیل عدد به کلمه دوگانه قبل از تقسیم آن بر 10 استفاده می‌کند.
* روال از دستور `MUL` برای ضرب مقدار دسیمالی در 10 و اضافه کردن آن به رجیستر `ax` استفاده می‌کند.

**پیشنهادات برای بهبود**

* روال می‌تواند با اضافه کردن مدیریت خطا برای ورودی‌های نامعتبر بهبود یابد.
* روال می‌تواند با استفاده از الگوریتم مؤثرتری برای تبدیل رشته به عدد بهبود یابد.

**نام :** `read_number.asm`

====================================================================================================

**English Document**

**Procedure to Get a Positive Number from the Keyboard**

This procedure reads a positive number from the keyboard and stores it in the `ax` register. The number must be between 0 and 99.

**Breakdown of the Code**

1. The procedure initializes the `ax` register to 0.
2. The `GETSTR1` macro is called to read a string from the keyboard and store it in the `NUMBER` variable.
3. The procedure checks if the first character of the string is a carriage return (0DH). If it is, the procedure jumps to the `@ERROR` label.
4. The procedure checks if the first character of the string is a minus sign (-). If it is not, the procedure jumps to the `mosbat` label.
5. The procedure prints an error message and jumps back to the beginning of the loop.
6. The `mosbat` label is reached if the number is positive. The procedure converts the first character of the string to a decimal value and adds it to the `ax` register.
7. The procedure multiplies the `ax` register by 10 and adds the next character of the string to it.
8. The procedure repeats steps 6 and 7 until it reaches the end of the string.

**Notes and Comments**

* The `GETSTR1` macro is used to read a string from the keyboard and store it in the `NUMBER` variable.
* The procedure uses the `CMP` instruction to compare the characters of the string with the ASCII values of the digits.
* The procedure uses the `SUB` instruction to convert the ASCII values to decimal values.

**Suggestions for Improvement**

* The procedure can be improved by adding error handling for invalid inputs.
* The procedure can be optimized by using a more efficient algorithm to convert the string to a number.

**Name:** `get_positive_number.asm`

**فارسی**

روال خواندن یک عدد مثبت از صفحه کلید

این روال عددی را از صفحه کلید می‌خواند و آن را در رجیستر `ax` ذخیره می‌کند. عدد باید بین 0 و 99 باشد.

**تجزیه و تحلیل کد**

1. روال رجیستر `ax` را به 0 初始化 می‌کند.
2. ماکرو `GETSTR1` برای خواندن یک رشته از صفحه کلید و ذخیره آن در متغیر `NUMBER` فراخوانی می‌شود.
3. روال بررسی می‌کند که آیا اولین کاراکتر رشته یک کاراکتر 回車 (0DH) است. اگر باشد، روال به برچسب `@ERROR` می‌رود.
4. روال بررسی می‌کند که آیا اولین کاراکتر رشته یک علامت منفی (-) است. اگر نباشد، روال به برچسب `mosbat` می‌رود.
5. روال یک پیام خطا را چاپ می‌کند و به ابتدای حلقه برمی‌گردد.
6. برچسب `mosbat` اگر عدد مثبت باشد، روال اولین کاراکتر رشته را به یک مقدار دسیمالی تبدیل می‌کند و آن را به رجیستر `ax` اضافه می‌کند.
7. روال رجیستر `ax` را در 10 ضرب می‌کند و کاراکتر بعدی رشته را به آن اضافه می‌کند.
8. روال مراحل 6 و 7 را تکرار می‌کند تا به انتهای رشته برسد.

**یادداشت‌ها و نظرات**

* ماکرو `GETSTR1` برای خواندن یک رشته از صفحه کلید و ذخیره آن در متغیر `NUMBER` استفاده می‌شود.
* روال از دستور `CMP` برای مقایسه کاراکترهای رشته با مقادیر ASCII رقم‌ها استفاده می‌کند.
* روال از دستور `SUB` برای تبدیل مقادیر ASCII به مقادیر دسیمالی استفاده می‌کند.

**پیشنهادات برای بهبود**

* روال می‌تواند با اضافه کردن مدیریت خطا برای ورودی‌های نامعتبر بهبود یابد.
* روال می‌تواند با استفاده از الگوریتم مؤثرتری برای تبدیل رشته به عدد بهبود یابد.

**نام :** `get_positive_number.asm`

