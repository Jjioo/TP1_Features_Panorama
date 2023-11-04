clear all
close all
clc

%% lire les images

I1 = imread('images/campus_01.jpg'); %  première image.
I2 = imread('images/campus_02.jpg'); % deuxième image

%% Extraire les features et leurs descripteurs
% detecte les features pour I1
gI = rgb2gray(I1); % convertir I1 en niveau de gris (vous pouvez ajouter un test pour vérifier si c'est une image couleur)
P1 = detectSURFFeatures(gI);            %detecter les features SURF 
[F1, P1] = extractFeatures(gI, P1);     % extraire les descripteurs 

% % afficher les features
% figure; imshow(I1); hold on
% plot(P1.selectStrongest(500),'showOrientation',true);
% hold off

% detecte les features pour I2.
gI = rgb2gray(I2); % convertir I2 en niveau de gris.
P2 = detectSURFFeatures(gI);
[F2, P2] = extractFeatures(gI, P2);

%     % afficher les features
%     figure; imshow(I2); hold on
%     plot(P2.selectStrongest(500),'showOrientation',true);
%     hold off


imageSize = zeros(1,2);

% Save image size.
imageSize(1,:) = size(gI);


%% Matching I2 <--> I1

indexPairs = matchFeatures(F2, F1, 'Unique', true);

% Visualizer le result du matching
% matchedPoints1 = P1(indexPairs(1:50, 1));
% matchedPoints2 = P2(indexPairs(1:50, 2));
% figure; ax = axes;
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);

matchedPoints2 = P2(indexPairs(:,1), :);
matchedPoints1 = P1(indexPairs(:,2), :);

%% Estimer la transformation entre I2 et I1.

% la modèle projective est utilié ici mais vous pouvez tester avec le modèle
% affine avec affine2d.

tforms = projective2d(eye(3));
tforms = estimateGeometricTransform(matchedPoints2, matchedPoints1,...
    'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);


%% Créer le panorama

% Calculer les limites            
[xlim(1,:), ylim(1,:)] = outputLimits(tforms, [1 imageSize(1,2)], [1 imageSize(1,1)]);

% minimum et maximum des limits 
xMin = min([1; xlim(:)]);
xMax = max([imageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([imageSize(1); ylim(:)]);

% Width et height du panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initializer le panorama 'vide".
panorama = zeros([height width 3], 'like', I2);

blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');  

% Créer l'image qui contiendra le panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
Vpanorama = imref2d([height width], xLimits, yLimits);

% Ajouter les images au panorama.
panorama(1:imageSize(1,1),1:imageSize(1,2),:)=I1;  %placer la première image

% Transformer I2 dans le panorama.
warpedImage = imwarp(I2, tforms, 'OutputView', Vpanorama);
%figure, imshow(warpedImage);

% Générer le masque binair.
mask = imwarp(true(size(I2,1),size(I2,2)), tforms, 'OutputView', Vpanorama);

% Superposer l'image transformée sur le panorama.
panorama = step(blender, panorama, warpedImage, mask);

% show the result
figure
imshow(panorama)
