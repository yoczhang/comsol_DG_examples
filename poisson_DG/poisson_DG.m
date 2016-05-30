function out = model
%
% poisson_DG.m
%
% Model exported on May 30 2016, 17:19 by COMSOL 5.2.0.166.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/home/yczhang/Documents/comsol_DG_examples/poisson_DG');

model.label('poisson_DG.mph');

model.comments([native2unicode(hex2dec({'67' '2a'}), 'unicode')  native2unicode(hex2dec({'54' '7d'}), 'unicode')  native2unicode(hex2dec({'54' '0d'}), 'unicode') '\n\n']);

model.baseSystem('none');

model.modelNode.create('comp1');

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').run;

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('f', '2*pi^2*sin(pi*x)*sin(pi*y)');
model.variable('var1').set('g', '0');
model.variable('var1').set('exactsoln', 'sin(pi*x)*sin(pi*y)');
model.variable('var1').set('error', 'abs(u-exactsoln)');
model.variable('var1').set('l2err', 'error^2');
model.variable('var1').set('ujump', 'up(u)-down(u)');
model.variable('var1').set('testujump', 'test(up(u))-test(down(u))');
model.variable('var1').set('unavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)');
model.variable('var1').set('testunavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');
model.variable('var1').set('sigma', '10');
model.variable('var1').set('l2', 'intop1(l2err)');
model.variable('var1').set('L2', 'sqrt(l2)');

model.view.create('view2', 3);

model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').selection.all;

model.physics.create('w', 'WeakFormPDE', 'geom1');
model.physics('w').create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('w').feature('ibweak1').selection.all;
model.physics('w').create('weak1', 'WeakContribution', 1);
model.physics('w').feature('weak1').selection.all;

model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').feature('map1').create('size1', 'Size');

model.view('view1').axis.set('abstractviewxscale', '0.0022633743938058615');
model.view('view1').axis.set('ymin', '-0.17394673824310303');
model.view('view1').axis.set('xmax', '1.024999976158142');
model.view('view1').axis.set('abstractviewyscale', '0.0022633743938058615');
model.view('view1').axis.set('abstractviewbratio', '-0.01718105934560299');
model.view('view1').axis.set('abstractviewtratio', '0.017181038856506348');
model.view('view1').axis.set('abstractviewrratio', '0.06810688972473145');
model.view('view1').axis.set('xmin', '-0.024999963119626045');
model.view('view1').axis.set('abstractviewlratio', '-0.06810695677995682');
model.view('view1').axis.set('ymax', '1.173946499824524');

model.physics('w').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('w').feature('wfeq1').set('weak', 'ux*test(ux)+uy*test(uy)-f*test(u)');
model.physics('w').feature('ibweak1').set('weakExpression', '-unavg*testujump-ujump*testunavg+(sigma/h)*ujump*testujump');
model.physics('w').feature('weak1').set('weakExpression', '-(ux*nx+uy*ny)*test(u)-(u-g)*((test(ux)*nx+test(uy)*ny)-sigma*test(u)/h)');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1/8');
model.mesh('mesh1').feature('map1').set('adjustedgdistr', true);
model.mesh('mesh1').feature('map1').feature('size1').set('custom', 'on');
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', true);
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', '1/8');
model.mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').create('surf1', 'Surface');
model.result.export.create('data1', 'Data');

model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result.export('data1').set('lagorder', '3');
model.result.export('data1').set('filename', '/home/yczhang/Documents/comsol_DG_examples/poisson_DG/Untitled.txt');
model.result.export('data1').set('resolution', 'custom');
model.result.export('data1').set('unit', {''});
model.result.export('data1').set('descr', {[native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u']});
model.result.export('data1').set('expr', {'u'});

out = model;
