function [X_smacof, keypoint_indices, geodesics] = getfacemds(filename)
file_base = split('human_face4_1_4k.mat','.');
file_base = file_base{1};

% load mesh
load(filename, 'human_face_4k');

% load keypoints
load(strcat(file_base, '_keypoints.mat'), 'keypoints');

mesh = human_face_4k;
mesh.D = fastmarch(mesh.TRIV,mesh.X,mesh.Y,mesh.Z);

options.X0 = [mesh.X,mesh.Y,mesh.Z];
options.method = 'smacof';

[X_smacof,~] = mds(mesh.D,options);

% get the indices of the features
mesh_verts = [mesh.X, mesh.Y, mesh.Z];

keypoint_indices = [];
for i = keypoints'
    index = find(ismember(mesh_verts, i','rows'));
    keypoint_indices = [keypoint_indices; index(1)];
end

geodesics = mesh.D;
