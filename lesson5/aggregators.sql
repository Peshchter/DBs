/*
����������� ������� ������� ������������� � ������� users
*/

/*
 * � ����� ������� ��� ���� � �����, �� ����� ����������� , 
 * ��� ���� birthday, ��� � profiles
 */


SELECT round(SUM(datediff(now(),birthday)/365)/COUNT(*)) FROM users

/**
 * ��������� ������� �������� =(
 */