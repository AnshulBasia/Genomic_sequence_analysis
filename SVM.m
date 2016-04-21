load train.txt;
train_no=1500;
total=2000;
data=train(1:train_no,:);
label=train(1:train_no,1);
plot_c_vs_ncrna_count=ones(50,2);
%SVMModel = svmtrain(train,label)
a=0.01;
for j=1:50
svmStruct = svmtrain(data,label,'ShowPlot',true,'boxconstraint',a);
load ncrna_test;
test=train(train_no+1:2000,:);
for k=1:total-train_no
    test(k,1)=0;
end
Group = svmclassify(svmStruct,test);

count = 0;
for i=1:total-train_no
    if Group(i,1) == train(train_no+i,1)
        count=count+1;
    end
end
accuracy=(count*100)/(total-train_no);
plot_c_vs_ncrna_count(j,2)=accuracy;
plot_c_vs_ncrna_count(j,1)=a;
a=a+0.01;
end
plot_c_vs_ncrna_count
plot(plot_c_vs_ncrna_count(:,1),plot_c_vs_ncrna_count(:,2))