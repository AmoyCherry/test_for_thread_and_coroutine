clc;
clear;

path_t_256 = '/Users/wangwenzhi/Documents/256B.xlsx';
path_c_256 = '/Users/wangwenzhi/Documents/cor_256B.xlsx';
path_avg_t_256 = '/Users/wangwenzhi/Documents/avg_thread_256B.xlsx';
path_avg_c_256 = '/Users/wangwenzhi/Documents/avg_cor_256B.xlsx';

path_t_4096 = '/Users/wangwenzhi/Documents/thread_4096B.xlsx';
path_c_4096 = '/Users/wangwenzhi/Documents/cor_4096B.xlsx';
path_avg_t_4096 = '/Users/wangwenzhi/Documents/avg_thread_4096B.xlsx';
path_avg_c_4096 = '/Users/wangwenzhi/Documents/avg_cor_4096B.xlsx';

thread_data = readtable(path_avg_t_256, 'VariableNamingRule', "preserve");
cor_data = readtable(path_avg_t_4096, 'VariableNamingRule', "preserve");


thread_x = double.empty;
thread_y = double.empty;
thread_z = double.empty;

cor_x = double.empty;
cor_y = double.empty;
cor_z = double.empty;

for i = 2:24
    for j = 2:21
        if ~isnan(table2array(thread_data(i:i, j:j)))
            tempx = table2array(thread_data(i:i, 1:1));
            tempy = table2array(thread_data(1:1, j:j));
            tempz = table2array(thread_data(i:i, j:j));

            thread_x(end + 1) = tempx(1);
            thread_y(end + 1) = tempy(1);
            thread_z(end + 1) = tempz(1);

            tempx = table2array(cor_data(i:i, 1:1));
            tempy = table2array(cor_data(1:1, j:j));
            tempz = table2array(cor_data(i:i, j:j));

            cor_x(end + 1) = tempx(1);
            cor_y(end + 1) = tempy(1);
            cor_z(end + 1) = tempz(1);
        end
    end
end


[X,Y] = meshgrid(0:50:4000, 200:200:4000);


Z1 = griddata(thread_x, thread_y, thread_z, X, Y);
mesh(X,Y,Z1)
hold on

Z2 = griddata(cor_x, cor_y, cor_z, X, Y);
mesh(X,Y,Z2)
hold on

xlabel('环长度');
ylabel('总任务数');
zlabel('时间(ms)');
hold on;

plot3(thread_x, thread_y, thread_z, '*')
plot3(cor_x, cor_y, cor_z, '+')




