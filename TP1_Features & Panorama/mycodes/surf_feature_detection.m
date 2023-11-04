% Load images
ship1 = imread('../images/ship1.jpg');
ship2 = imread('../images/ship2.jpg');

% Detect SURF features in castle1 and castle2
features_castle1 = detectSURFFeatures(castle1);
features_castle2 = detectSURFFeatures(castle2);

% Visualize detected features (optional)
figure;
imshow(castle1);
hold on;
plot(features_castle1);
title('Detected SURF Features in Castle1');

figure;
imshow(castle2);
hold on;
plot(features_castle2);
title('Detected SURF Features in Castle2');
