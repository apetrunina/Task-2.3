-- Задание 1: Возвращает список клиентов (имя и фамилия) с наибольшей общей суммой заказов
SELECT c.FirstName, c.LastName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY SUM(o.TotalAmount) DESC
LIMIT 1;

-- Задание 2: Для каждого клиента из пункта 1 выводит список его заказов (номер заказа и общая сумма) в порядке убывания общей суммы заказов
SELECT o.OrderID, o.TotalAmount
FROM Orders o
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.CustomerID = (
  SELECT c.CustomerID
  FROM Customers c
  JOIN Orders o ON c.CustomerID = o.CustomerID
  GROUP BY c.FirstName, c.LastName
  ORDER BY SUM(o.TotalAmount) DESC
  LIMIT 1
)
ORDER BY o.TotalAmount DESC;

-- Задание 3: Выводит только тех клиентов, у которых общая сумма заказов превышает среднюю общую сумму заказов всех клиентов
SELECT c.FirstName, c.LastName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING SUM(o.TotalAmount) > (
  SELECT AVG(TotalAmount)
  FROM Orders
);
