function out = model
%
% to_test.m
%
% Model exported on May 30 2016, 17:30 by COMSOL 5.2.0.166.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('/home/yczhang/Documents/comsol_DG_examples/stokes_DG');

model.modelNode.create('comp1');

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.physics.create('spf', 'LaminarFlow', 'geom1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').activate('spf', true);

model.param.set('nu', '1/800', 'dynamical viscosity');
model.param.set('uin', '0', 'constant to generate the control matrix');
model.param.set('umax', '3/2', 'u max');
model.param.set('Re', 'D*umean/nu', 'Reynolds number');
model.param.set('D', '0.1', 'diameter of disk');
model.param.set('umean', '1', 'mean value of inlet velocity');
model.param.set('rho', '1');

model.geom('geom1').create('r1', 'Rectangle');
model.geom('geom1').feature('r1').set('size', {'3.7' '0.4'});
model.geom('geom1').feature('r1').set('pos', {'-1.5' '0'});
model.geom('geom1').run('r1');
model.geom('geom1').run('r1');
model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').set('r', '0.05');
model.geom('geom1').feature('c1').set('pos', {'0.25' '0.2'});
model.geom('geom1').run('c1');
model.geom('geom1').run('fin');

model.physics('spf').prop('PhysicalModelProperty').set('Compressibility', 'Incompressible');
model.physics('spf').prop('PhysicalModelProperty').setIndex('StokesFlowProp', '1', 0);
model.physics('spf').feature('fp1').set('rho_mat', 'userdef');
model.physics('spf').feature('fp1').set('rho', 'rho');
model.physics('spf').feature('fp1').set('mu_mat', 'userdef');
model.physics('spf').feature('fp1').set('mu', 'nu');

model.geom('geom1').run('c1');
model.geom('geom1').create('dif1', 'Difference');
model.geom('geom1').feature('dif1').selection('input').set({'r1'});
model.geom('geom1').feature('dif1').selection('input2').set({'c1'});
model.geom('geom1').runPre('fin');
model.geom('geom1').run('fin');

model.physics('spf').feature('init1').set('u', {'umax*4*y*(1-y)' '0' '0'});
model.physics('spf').feature.create('inl1', 'InletBoundary', 1);
model.physics('spf').feature('inl1').selection.set([1]);
model.physics('spf').feature('inl1').set('U0in', 'umax*4*s*(1-s)');
model.physics('spf').feature.create('out1', 'OutletBoundary', 1);
model.physics('spf').feature('out1').selection.set([4]);
model.physics('spf').feature('out1').set('BoundaryCondition', 'Pressure');

model.mesh('mesh1').automatic(false);
model.mesh('mesh1').automatic(true);
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1');
model.mesh('mesh1').feature('size').set('hmin', '0.005');
model.mesh('mesh1').feature('size').set('hgrad', '1.1');
model.mesh('mesh1').feature('size').set('hcurve', '0.1');
model.mesh('mesh1').feature.remove('size1');
model.mesh('mesh1').feature.remove('cr1');
model.mesh('mesh1').feature.remove('bl1');
model.mesh('mesh1').feature('size').set('table', 'default');
model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1');
model.mesh('mesh1').feature('size').set('hmin', '0.005');
model.mesh('mesh1').feature('size').set('hgrad', '1.1');
model.mesh('mesh1').feature('size').set('hcurve', '0.1');
model.mesh('mesh1').run;

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').label([native2unicode(hex2dec({'90' '1f'}), 'unicode')  native2unicode(hex2dec({'5e' 'a6'}), 'unicode') ' (spf)']);
model.result('pg1').set('oldanalysistype', 'noneavailable');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').feature.create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('oldanalysistype', 'noneavailable');
model.result('pg1').feature('surf1').set('data', 'parent');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').label([native2unicode(hex2dec({'53' '8b'}), 'unicode')  native2unicode(hex2dec({'52' '9b'}), 'unicode') ' (spf)']);
model.result('pg2').set('oldanalysistype', 'noneavailable');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('data', 'dset1');
model.result('pg2').feature.create('con1', 'Contour');
model.result('pg2').feature('con1').set('oldanalysistype', 'noneavailable');
model.result('pg2').feature('con1').set('expr', 'p');
model.result('pg2').feature('con1').set('number', 40);
model.result('pg2').feature('con1').set('data', 'parent');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;

model.physics.create('g', 'GeneralFormPDE', 'geom1', {'u2'});

model.study('std1').feature('stat').activate('g', true);

model.physics.create('g2', 'GeneralFormPDE', 'geom1', {'u3'});

model.study('std1').feature('stat').activate('g2', true);

model.physics('g').field('dimensionless').component({'u2' 'u22'});
model.physics('g').field('dimensionless').component(2, 'v2');
model.physics.remove('g');
model.physics.remove('g2');
model.physics.create('w', 'WeakFormPDE', 'geom1', {'u2'});

model.study('std1').feature('stat').activate('w', true);

model.physics.create('w2', 'WeakFormPDE', 'geom1', {'u3'});

model.study('std1').feature('stat').activate('w2', true);

model.physics('w').field('dimensionless').component({'u2' 'u22'});
model.physics('w').field('dimensionless').component(2, 'v2');
model.physics('w2').field('dimensionless').field('p2');
model.physics('w2').field('dimensionless').component(1, 'p2');
model.physics('w').feature('wfeq1').setIndex('weak', '-test(u)*ut+test(ux)*(p-nu*ux)+test(uy)*(-nu*uy)', 0);
model.physics('w').feature('wfeq1').setIndex('weak', '-test(v)*vt+test(vx)*(-nu*vx)+test(vy)*(p-nu*vy)', 1);
model.physics('w').feature.create('dir1', 'DirichletBoundary', 1);
model.physics('w').feature('dir1').selection.set([1]);
model.physics('w').feature('dir1').setIndex('r', 'umax*4*y*(1-y)', 0);
model.physics('w').feature.create('dir2', 'DirichletBoundary', 1);
model.physics('w').feature('dir2').selection.set([2 3 5 6 7 8]);
model.physics('w').feature('init1').set('u2', 'umax*4*y*(1-y)');
model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)', 0);

model.study('std1').feature('stat').set('physselection', 'spf');
model.study('std1').feature('stat').set('activate', {'spf' 'on' 'w' 'off' 'w2' 'on'});
model.study('std1').feature('stat').set('physselection', 'spf');
model.study('std1').feature('stat').set('activate', {'spf' 'on' 'w' 'off' 'w2' 'off'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').activate('spf', false);
model.study('std2').feature('stat').activate('w', true);
model.study('std2').feature('stat').activate('w2', true);

model.sol.create('sol2');
model.sol('sol2').study('std2');

model.study('std2').feature('stat').set('notlistsolnum', 1);
model.study('std2').feature('stat').set('notsolnum', '1');
model.study('std2').feature('stat').set('listsolnum', 1);
model.study('std2').feature('stat').set('solnum', '1');

model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');

model.result.create('pg3', 2);
model.result('pg3').set('data', 'dset2');
model.result('pg3').create('surf1', 'Surface');
model.result('pg3').feature('surf1').set('expr', 'u2');
model.result.create('pg4', 2);
model.result('pg4').set('data', 'dset2');
model.result('pg4').create('surf1', 'Surface');
model.result('pg4').feature('surf1').set('expr', 'p2');

model.physics('w').feature('wfeq1').setIndex('weak', '-test(u2)*u2t+test(u2x)*(p2-nu*u2x)+test(u2y)*(-nu*u2y)', 0);
model.physics('w').feature('wfeq1').setIndex('weak', '-test(v2)*v2t+test(v2x)*(-nu*v2x)+test(v2y)*(p2-nu*v2y)', 1);
model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p2)*(u2x+v2y)', 0);

model.sol('sol2').study('std2');

model.study('std2').feature('stat').set('notlistsolnum', 1);
model.study('std2').feature('stat').set('notsolnum', '1');
model.study('std2').feature('stat').set('listsolnum', 1);
model.study('std2').feature('stat').set('solnum', '1');

model.sol('sol2').feature.remove('s1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');

model.label('mystones.mph');

model.physics('w2').prop('ShapeProperty').set('order', '1');

model.sol('sol2').study('std2');

model.study('std2').feature('stat').set('notlistsolnum', 1);
model.study('std2').feature('stat').set('notsolnum', '1');
model.study('std2').feature('stat').set('listsolnum', 1);
model.study('std2').feature('stat').set('solnum', '1');

model.sol('sol2').feature.remove('s1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg3').run;
model.result('pg3').set('allowtableupdate', false);
model.result('pg3').set('title', [native2unicode(hex2dec({'88' '68'}), 'unicode')  native2unicode(hex2dec({'97' '62'}), 'unicode') ': ' native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u2 (1)']);
model.result('pg3').set('xlabel', '');
model.result('pg3').set('ylabel', '');
model.result('pg3').feature('surf1').set('rangeunit', '1');
model.result('pg3').feature('surf1').set('rangecolormin', -2.220446049250313E-16);
model.result('pg3').feature('surf1').set('rangecolormax', 1.6152626410658357);
model.result('pg3').feature('surf1').set('rangecoloractive', 'off');
model.result('pg3').feature('surf1').set('rangedatamin', -2.220446049250313E-16);
model.result('pg3').feature('surf1').set('rangedatamax', 1.6152626410658357);
model.result('pg3').feature('surf1').set('rangedataactive', 'off');
model.result('pg3').feature('surf1').set('rangeactualminmax', [-2.220446049250313E-16 1.6152626410658357]);
model.result('pg3').set('renderdatacached', false);
model.result('pg3').set('allowtableupdate', true);
model.result('pg3').set('renderdatacached', true);
model.result.table.create('evl2', 'Table');
model.result.table('evl2').comments([native2unicode(hex2dec({'4e' 'a4'}), 'unicode')  native2unicode(hex2dec({'4e' '92'}), 'unicode')  native2unicode(hex2dec({'76' '84'}), 'unicode')  native2unicode(hex2dec({'4e' '8c'}), 'unicode')  native2unicode(hex2dec({'7e' 'f4'}), 'unicode')  native2unicode(hex2dec({'50' '3c'}), 'unicode') ]);
model.result.table('evl2').label('Evaluation 2D');
model.result.table('evl2').addRow([-1.3677393198013306 0.18187087774276733 1.090958213607306]);

model.physics('w').feature('init1').set('u2', 'umax*4*y*(0.4-y)');
model.physics('w').feature('dir1').setIndex('r', 'umax*4*y*(0.4-y)', 0);
model.physics('w').feature('dir1').setIndex('r', 'umax*4*s*(1-s)', 0);

model.sol('sol2').study('std2');

model.study('std2').feature('stat').set('notlistsolnum', 1);
model.study('std2').feature('stat').set('notsolnum', '1');
model.study('std2').feature('stat').set('listsolnum', 1);
model.study('std2').feature('stat').set('solnum', '1');

model.sol('sol2').feature.remove('s1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg3').run;

model.physics('spf').prop('ShapeProperty').set('order_fluid', '2');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'u2-u');
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'u2');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg4').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'v2');
model.result('pg3').run;
model.result('pg1').run;
model.result('pg4').run;
model.result('pg4').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').feature('surf1').set('expr', 'u2');
model.result('pg3').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u-u2');
model.result('pg1').run;
model.result.dataset.create('join1', 'Join');
model.result.dataset('join1').set('method', 'explicit');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'data1(u)-data2(u2)');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').set('data', 'none');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('data', 'dset1');
model.result.create('pg5', 'PlotGroup2D');
model.result('pg5').run;
model.result.dataset('join1').set('method', 'general');
model.result('pg1').run;
model.result('pg5').run;
model.result.dataset.remove('join1');
model.result.dataset.create('join1', 'Join');
model.result.dataset('join1').set('data', 'dset1');
model.result.dataset('join1').set('data2', 'dset2');
model.result.dataset('join1').set('method', 'explicit');
model.result('pg1').run;
model.result('pg1').set('data', 'join1');
model.result.dataset('join1').set('method', 'difference');
model.result('pg1').feature('surf1').set('expr', 'u-u2');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('data', 'join1');
model.result('pg1').run;
model.result.dataset('join1').set('method', 'explicit');
model.result.remove('pg1');
model.result('pg5').run;
model.result('pg5').set('data', 'join1');
model.result('pg5').create('surf1', 'Surface');
model.result('pg5').feature('surf1').set('expr', 'data1(u)');
model.result('pg5').run;
model.result('pg5').feature('surf1').set('unit', '');
model.result('pg5').feature('surf1').set('expr', 'data1(u)-data2(u2)');
model.result('pg5').run;
model.result('pg5').feature('surf1').create('filt1', 'Filter');
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').feature('surf1').feature('filt1').set('expr', '(data1(u)-data2(u2))>0.01*data1(u)');
model.result('pg5').feature('surf1').feature.remove('filt1');
model.result('pg5').run;

model.physics('spf').prop('InconsistentStabilization').setIndex('IsotropicDiffusion', '1', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg2').run;
model.result('pg5').run;

model.physics('spf').prop('ConsistentStabilization').setIndex('StreamlineDiffusion', '0', 0);
model.physics('spf').prop('InconsistentStabilization').setIndex('IsotropicDiffusion', '0', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg2').run;
model.result('pg5').run;
model.result('pg5').run;
model.result.create('pg6', 'PlotGroup2D');
model.result('pg6').run;
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').set('expr', 'ux+vy');
model.result('pg6').run;
model.result('pg6').set('allowtableupdate', false);
model.result('pg6').set('title', [native2unicode(hex2dec({'88' '68'}), 'unicode')  native2unicode(hex2dec({'97' '62'}), 'unicode') ': ux+vy (1/s)']);
model.result('pg6').set('xlabel', '');
model.result('pg6').set('ylabel', '');
model.result('pg6').feature('surf1').set('rangeunit', '1/s');
model.result('pg6').feature('surf1').set('rangecolormin', -0.7816970499418089);
model.result('pg6').feature('surf1').set('rangecolormax', 0.2592563440836511);
model.result('pg6').feature('surf1').set('rangecoloractive', 'off');
model.result('pg6').feature('surf1').set('rangedatamin', -0.7816970499418089);
model.result('pg6').feature('surf1').set('rangedatamax', 0.2592563440836511);
model.result('pg6').feature('surf1').set('rangedataactive', 'off');
model.result('pg6').feature('surf1').set('rangeactualminmax', [-0.7816970499418089 0.2592563440836511]);
model.result('pg6').set('renderdatacached', false);
model.result('pg6').set('allowtableupdate', true);
model.result('pg6').set('renderdatacached', true);
model.result.table('evl2').addRow([-0.874337375164032 0.026948826387524605 8.376843829444272E-10]);
model.result.table('evl2').addRow([-0.44170933961868286 0.21730516850948334 -4.105239560277503E-7]);
model.result.table('evl2').addRow([0.7609966993331909 0.23461028933525085 1.0251758573808834E-5]);
model.result.table('evl2').addRow([1.0897940397262573 0.20865261554718018 1.6260990279431866E-7]);
model.result.table('evl2').addRow([1.2541927099227905 0.14808468520641327 2.9030420281167016E-7]);
model.result.table('evl2').addRow([1.4532015323638916 0.1221269965171814 -2.4732262900858716E-5]);
model.result.table('evl2').addRow([1.6089476346969604 0.11347443610429764 -2.9040972485288105E-4]);
model.result.table('evl2').addRow([2.1021437644958496 0.19134747982025146 0.23354160780869432]);
model.result('pg2').run;
model.result('pg3').run;

model.mesh('mesh1').automatic(true);
model.mesh('mesh1').autoMeshSize(1);
model.mesh('mesh1').run;
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').run;
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size').set('hauto', '5');
model.mesh('mesh1').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.mesh('mesh1').feature('size').set('hauto', '7');
model.mesh('mesh1').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.mesh('mesh1').feature('size').set('hauto', '8');
model.mesh('mesh1').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.mesh('mesh1').feature('size').set('hauto', '9');
model.mesh('mesh1').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1');
model.mesh('mesh1').feature('size').set('hmin', '0.005');
model.mesh('mesh1').feature('size').set('hgrad', '1.1');
model.mesh('mesh1').feature('size').set('hcurve', '0.1');
model.mesh('mesh1').feature('size').set('hnarrow', '1');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size1').set('custom', 'off');
model.mesh('mesh1').feature('size').set('custom', 'off');
model.mesh('mesh1').feature('size1').set('hauto', '9');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size').set('hauto', '5');
model.mesh('mesh1').feature('size1').set('hauto', '5');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size').set('hauto', '7');
model.mesh('mesh1').feature('size1').set('hauto', '7');
model.mesh('mesh1').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'd1');
model.sol('sol1').feature('s1').feature('fc1').set('initstep', 0.01);
model.sol('sol1').feature('s1').feature('fc1').set('minstep', 1.0E-6);
model.sol('sol1').feature('s1').feature('fc1').set('dtech', 'auto');
model.sol('sol1').feature('s1').feature('fc1').set('maxiter', 25);
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg2').run;

model.sol('sol2').study('std2');

model.study('std2').feature('stat').set('notlistsolnum', 1);
model.study('std2').feature('stat').set('notsolnum', '1');
model.study('std2').feature('stat').set('listsolnum', 1);
model.study('std2').feature('stat').set('solnum', '1');

model.sol('sol2').feature.remove('s1');
model.sol('sol2').feature.remove('v1');
model.sol('sol2').feature.remove('st1');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').feature('st1').set('study', 'std2');
model.sol('sol2').feature('st1').set('studystep', 'stat');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').feature('v1').set('control', 'stat');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('seDef', 'Segregated');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol2').feature('s1').feature.remove('fcDef');
model.sol('sol2').feature('s1').feature.remove('seDef');
model.sol('sol2').attach('std2');
model.sol('sol2').runAll;

model.result('pg3').run;
model.result('pg6').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg3').run;

model.comments([native2unicode(hex2dec({'6c' '42'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode') 'stokes' native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode')  native2unicode(hex2dec({'ff' '0c'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'52' '2b'}), 'unicode')  native2unicode(hex2dec({'4f' '7f'}), 'unicode')  native2unicode(hex2dec({'75' '28'}), 'unicode') 'CFD' native2unicode(hex2dec({'4e' '0e'}), 'unicode')  native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'5f' '62'}), 'unicode')  native2unicode(hex2dec({'5f' '0f'}), 'unicode') '\nP2+P1']);

model.label('Stokes.mph');

model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').set('allowtableupdate', false);
model.result('pg3').set('title', [native2unicode(hex2dec({'88' '68'}), 'unicode')  native2unicode(hex2dec({'97' '62'}), 'unicode') ': ' native2unicode(hex2dec({'56' 'e0'}), 'unicode')  native2unicode(hex2dec({'53' 'd8'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' u2 (1)']);
model.result('pg3').set('xlabel', '');
model.result('pg3').set('ylabel', '');
model.result('pg3').feature('surf1').set('rangeunit', '1');
model.result('pg3').feature('surf1').set('rangecolormin', -5.551115123125783E-17);
model.result('pg3').feature('surf1').set('rangecolormax', 1.9122043833027913);
model.result('pg3').feature('surf1').set('rangecoloractive', 'off');
model.result('pg3').feature('surf1').set('rangedatamin', -5.551115123125783E-17);
model.result('pg3').feature('surf1').set('rangedatamax', 1.9122043833027913);
model.result('pg3').feature('surf1').set('rangedataactive', 'off');
model.result('pg3').feature('surf1').set('rangeactualminmax', [-5.551115123125783E-17 1.9122043833027913]);
model.result('pg3').set('renderdatacached', false);
model.result('pg3').set('allowtableupdate', true);
model.result('pg3').set('renderdatacached', true);
model.result.table('evl2').addRow([-0.7185912728309631 0.2605679929256439 1.3589323187580096]);
model.result('pg6').run;
model.result('pg6').run;
model.result('pg5').run;

model.label('Stokes.mph');

model.comments(['Stokes\n\n' native2unicode(hex2dec({'6c' '42'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode') 'stokes' native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode')  native2unicode(hex2dec({'ff' '0c'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'52' '2b'}), 'unicode')  native2unicode(hex2dec({'4f' '7f'}), 'unicode')  native2unicode(hex2dec({'75' '28'}), 'unicode') 'CFD' native2unicode(hex2dec({'4e' '0e'}), 'unicode')  native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'5f' '62'}), 'unicode')  native2unicode(hex2dec({'5f' '0f'}), 'unicode') '\nP2+P1']);

model.result('pg5').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.physics.remove('spf');

model.baseSystem('none');

model.geom('geom1').feature.remove('c1');
model.geom('geom1').run('r1');
model.geom('geom1').feature.remove('dif1');
model.geom('geom1').run('fin');

model.physics('w').field('dimensionless').field('u');
model.physics('w').field('dimensionless').component(1, 'u');
model.physics('w').field('dimensionless').component(2, 'v');
model.physics('w').feature('wfeq1').setIndex('weak', 'nu*(ux*test(ux)+uy*test(uy))-p*test(ux)-f1*test(u)', 0);
model.physics('w').feature('wfeq1').setIndex('weak', 'nu*(uy*test(uy)+uy*test(uy))-p*test(ux)-f1*test(u)', 1);
model.physics('w').feature('wfeq1').setIndex('weak', 'nu*(vx*test(vx)+vy*test(vy))-p*test(vy)-f1*test(v)', 1);
model.physics('w2').field('dimensionless').field('p');
model.physics('w2').field('dimensionless').component(1, 'p');
model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)', 0);

model.variable.create('var1');
model.variable('var1').model('comp1');
model.variable('var1').set('ujump', 'up(u)-down(u)');
model.variable('var1').set('vjump', 'up(v)-down(v)');
model.variable('var1').set('pjump', 'up(p)-down(p)');
model.variable('var1').set('testujump', 'test(up(u))-test(down(u))');
model.variable('var1').set('testvjump', 'test(up(v))-test(down(v))');
model.variable('var1').set('testpjump', 'test(up(p))-test(down(p))');
model.variable('var1').set('u', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)');
model.variable('var1').rename('u', 'unavg');
model.variable('var1').set('unavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)');
model.variable('var1').set('vnavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)');
model.variable('var1').set('pnavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)');
model.variable('var1').set('vnavg', '0.5*((up(vx)+down(vx))*unx+(up(vy)+down(vy))*uny)');
model.variable('var1').set('pnavg', '0.5*((up(px)+down(px))*unx+(up(py)+down(py))*uny)');
model.variable('var1').set('testunavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');
model.variable('var1').set('testvnavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');
model.variable('var1').set('testpnavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');

model.physics('w').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('w').feature('ibweak1').selection.all;

model.label('Stokes.mph');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump-ujump*testunavg+(sigma/h)*ujump*testujump)+pjump*test(ujump)');

model.variable('var1').set('pavg', 'o.5*(up(p)+down(p))');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump-ujump*testunavg+(sigma/h)*ujump*testujump)+pavg*test(ujump)*nx');
model.physics('w').feature.create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump-vjump*testvnavg+(sigma/h)*vjump*testvjump)+pavg*testvjump*ny');
model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump-ujump*testunavg+(sigma/h)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature.create('weak1', 'WeakContribution', 1);
model.physics('w').feature('weak1').selection.all;
model.physics('w').feature('weak1').selection.set([1 2 3]);
model.physics('w').feature('dir1').setIndex('r', '0', 0);

model.geom('geom1').feature.remove('r1');
model.geom('geom1').run('');
model.geom('geom1').create('sq1', 'Square');
model.geom('geom1').run('sq1');
model.geom('geom1').run;

model.physics('w').feature('dir2').selection.all;
model.physics('w').feature.remove('dir1');
model.physics('w2').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('w').feature('dir2').active(false);
model.physics('w').feature('dir2').active(true);
model.physics('w2').feature('ibweak1').set('weakExpression', 'pavg*(ujunp*nx+vjump*ny)');
model.physics('w2').feature.create('dir1', 'DirichletBoundary', 1);
model.physics('w2').feature('dir1').selection.all;

model.variable('var1').set('f1', '0');
model.variable('var1').set('f2', '0');

model.study.remove('std2');
model.study.remove('std1');

model.mesh.remove('mesh1');
model.mesh.create('mesh1', 'geom1');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').set('adjustedgdistr', 'on');
model.mesh('mesh1').feature('map1').create('size1', 'Size');
model.mesh('mesh1').feature('map1').feature('size1').set('custom', 'on');
model.mesh('mesh1').feature('map1').feature('size1').set('hmaxactive', 'on');
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', '1/16');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('map1').feature('size1').set('hmax', '1/8');
model.mesh('mesh1').run('map1');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').run('conv1');

model.param.set('nu', '1');

model.variable('var1').set('f1', 'f2=2*(2*x - 1)*(6*nu*x^2*y^2 - 6*nu*x^2*y + nu*x^2 - 6*nu*x*y^2 + 6*nu*x*y - nu*x + 3*nu*y^4 - 6*nu*y^3 + 3*nu*y^2 + 1)');
model.variable('var1').set('f2', '2*(2*x - 1)*(6*nu*x^2*y^2 - 6*nu*x^2*y + nu*x^2 - 6*nu*x*y^2 + 6*nu*x*y - nu*x + 3*nu*y^4 - 6*nu*y^3 + 3*nu*y^2 + 1)');
model.variable('var1').set('f1', '2*(2*y - 1)*(- 3*nu*x^4 + 6*nu*x^3 - 6*nu*x^2*y^2 + 6*nu*x^2*y - 3*nu*x^2 + 6*nu*x*y^2 - 6*nu*x*y - nu*y^2 + nu*y + 1)');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').activate('w', true);
model.study('std1').feature('stat').activate('w2', true);
model.study('std1').feature('stat').set('showdistribute', true);

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 2);
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'u');
model.result.create('pg2', 2);
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result.remove('pg2');
model.result.remove('pg1');

model.param.set('sigma', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 2);
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'u');
model.result.create('pg2', 2);
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result.remove('pg2');
model.result.remove('pg1');

model.variable('var1').set('pavg', '0.5*(up(p)+down(p))');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 2);
model.result('pg1').set('data', 'dset1');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'u');
model.result.create('pg2', 2);
model.result('pg2').set('data', 'dset1');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').feature('surf1').set('expr', 'p');

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('us', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)');

model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u-us');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'us');
model.result('pg1').run;

model.variable.create('var2');
model.variable('var2').model('comp1');
model.variable('var2').set('us', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable.remove('var2');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u-us');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;

model.cpl.create('linproj1', 'LinearProjection', 'geom1');
model.cpl('linproj1').selection('srcvertex3').geom('geom1', 0);
model.cpl('linproj1').selection('srcvertex2').geom('geom1', 0);
model.cpl('linproj1').selection('srcvertex1').geom('geom1', 0);
model.cpl('linproj1').selection('dstvertex2').geom('geom1', 0);
model.cpl('linproj1').selection('dstvertex1').geom('geom1', 0);
model.cpl.remove('linproj1');
model.cpl.create('intop1', 'Integration', 'geom1');
model.cpl('intop1').selection.all;

model.variable('var1').set('L2u', 'sqrt(intop1((u-us)^2))');

model.sol('sol1').updateSolution;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'L2u');
model.result('pg1').run;

model.mesh('mesh1').feature('map1').feature('size1').set('hmax', '1/16');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.physics('w2').feature.create('weak1', 'WeakContribution', 1);
model.physics('w2').feature('weak1').selection.all;
model.physics('w').feature('weak1').selection.all;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.physics('w2').feature('ibweak1').selection.all;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('ibweak1').set('weakExpression', 'pavg*(ujump*nx+vjump*ny)');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('map1').feature('size1').set('hmax', '1/8');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'v');
model.result('pg2').run;

model.physics('w').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('w2').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak2').active(false);
model.physics('w').feature('ibweak1').active(false);
model.physics('w2').feature('ibweak1').active(false);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').active(true);
model.physics('w').feature('ibweak2').active(true);
model.physics('w2').feature('ibweak1').active(true);
model.physics('w').feature('init1').set('u', '0');
model.physics('w2').feature('init1').set('p', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').active(false);
model.physics('w').feature('ibweak2').active(false);
model.physics('w2').feature('ibweak1').active(false);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').active(true);
model.physics('w').feature('ibweak2').active(true);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('ibweak1').active(true);

model.param.set('nu', '0.01');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('nu', '1');

model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)+e-6', 0);
model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)+test(p)*p/10^6', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('dir1').setIndex('useDirichletCondition', '0', 0);
model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)+test(p)*p/10^3', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)+test(p)*p/10', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('weak1').active(false);
model.physics('w').feature('ibweak2').active(false);
model.physics('w').feature('ibweak1').active(false);
model.physics('w2').feature('ibweak1').active(false);
model.physics('w2').feature('dir1').active(false);
model.physics('w2').feature.create('constr1', 'PointwiseConstraint', 0);
model.physics('w2').feature('constr1').selection.set([2]);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature.create('cons1', 'Constraint', 1);
model.physics('w2').feature('cons1').selection.all;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('wfeq1').setIndex('weak', 'nu*(vx*test(vx)+vy*test(vy))-p*test(vy)-f2*test(v)', 1);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('init1').set('u', '1');
model.physics('w').feature('init1').set('v', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak2').selection.all;
model.physics('w').feature('ibweak1').active(true);
model.physics('w').feature('ibweak2').active(true);
model.physics('w').feature('weak1').active(true);
model.physics('w2').feature('ibweak1').active(true);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('constr1').set('constraintExpression', 'p');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('dir1').active(true);
model.physics('w2').feature('dir1').setIndex('useDirichletCondition', '1', 0);
model.physics('w2').feature.create('ptsrc1', 'PointSourceTerm', 0);
model.physics('w2').feature.remove('constr1');
model.physics('w2').feature.remove('ptsrc1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.label('Stokes.mph');

model.param.set('eipsilon', '1');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump-eipsilon*ujump*testunavg+(sigma/h)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump+eipsilon*vjump*testvnavg+(sigma/h)*vjump*testvjump)+pavg*testvjump*ny');
model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump+eipsilon*ujump*testunavg+(sigma/h)*ujump*testujump)+pavg*testujump*nx');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump+eipsilon*ujump*testunavg+(sigma/h^2)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump+eipsilon*vjump*testvnavg+(sigma/h^2)*vjump*testvjump)+pavg*testvjump*ny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump+eipsilon*ujump*testunavg+(sigma/h^3)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump+eipsilon*vjump*testvnavg+(sigma/h^3)*vjump*testvjump)+pavg*testvjump*ny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump+eipsilon*ujump*testunavg+(sigma/h^4)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump+eipsilon*vjump*testvnavg+(sigma/h^4)*vjump*testvjump)+pavg*testvjump*ny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)+test(p)*p*1e-6', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump+eipsilon*ujump*testunavg+(sigma/h^2)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump+eipsilon*vjump*testvnavg+(sigma/h^2)*vjump*testvjump)+pavg*testvjump*ny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.label('Stokes.mph');

model.physics('w').feature.remove('dir2');
model.physics('w').feature.create('weak2', 'WeakContribution', 1);

model.variable('var1').set('g1', '0');
model.variable('var1').set('g2', '0');

model.physics('w').feature('weak1').set('weakExpression', 'nu*sigma/h*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*testu*nx-nu*eipsilon*testun*g1-nu*sigma/h*test(u)*g1');
model.physics('w').feature('weak2').set('weakExpression', 'nu*sigma/h*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*testv*ny-nu*eipsilon*testvn*g1-nu*sigma/h*test(v)*g2');
model.physics('w').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*testu*nx-nu*eipsilon*testun*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('w').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*testv*ny-nu*eipsilon*testvn*g1-nu*sigma/h^beta*test(v)*g2');

model.param.set('beta', '2');

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(-unavg*testujump+eipsilon*ujump*testunavg+(sigma/h^beta)*ujump*testujump)+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(-vnavg*testvjump+eipsilon*vjump*testvnavg+(sigma/h^beta)*vjump*testvjump)+pavg*testvjump*ny');
model.physics('w2').feature.create('weak2', 'WeakContribution', 1);
model.physics('w2').feature.remove('weak2');
model.physics('w2').feature('weak1').set('weakExpression', 'test(p)');

model.variable('var1').set('testpavg', '0.5*(test(up(p))+test(down(p)))');

model.physics('w2').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*nx+ujump*ny)');
model.physics('w2').feature('weak1').set('weakExpression', 'test(p)*(ux*nx+vy*ny)');
model.physics('w2').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*nx+vjump*ny)');
model.physics('w2').feature('weak1').set('weakExpression', 'test(p)*(ux*nx+vy*ny)-test(p)*(g1*nx+g2*ny)');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*test(un)*u+p*test(u)*nx-nu*eipsilon*test(un)*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('w').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*test(vn)*v+p*test(v)*ny-nu*eipsilon*test(vn)*g1-nu*sigma/h^beta*test(v)*g2');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('w').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*g1-nu*sigma/h^beta*test(v)*g2');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').set('testun', 'test(ux)*nx+test(uy)*ny');
model.variable('var1').set('testvn', 'test(vx)*nx+test(vy)*ny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').set('un', 'ux*nx+uy*ny');
model.variable('var1').set('vn', 'vx*nx+ny*ny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '3');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '2');
model.param.set('eipsilon', '-1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '3');

model.sol('sol1').updateSolution;

model.result('pg1').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '2');

model.variable('var1').remove('testpnavg');
model.variable('var1').remove('pnavg');

model.physics('w').feature('init1').set('u', '0');
model.physics('w').feature('init1').set('v', '0');
model.physics('w2').feature('init1').set('p', '0');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('dir1').setIndex('useDirichletCondition', '0', 0);
model.physics('w2').feature.remove('dir1');
model.physics('w2').feature.remove('cons1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'dense');

model.study('std1').feature('stat').set('showdistribute', true);

model.mesh('mesh1').feature('map1').feature('size1').set('hmax', '1/16');
model.mesh('mesh1').run('map1');

model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'mumps');
model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').rename('us', 'uexac');
model.variable('var1').set('uexac', 'x^2*(x-1)^2*y*(y-1)*(2*y-1)');
model.variable('var1').remove('L2u');
model.variable('var1').set('vexac', '-x*(x-1)*(2*x-1)*y^2*(y-1)^2');
model.variable('var1').set('g1', 'uexac');
model.variable('var1').set('g2', 'vexac');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').prop('ShapeProperty').set('order', '1');
model.physics('w2').prop('ShapeProperty').set('order', '0');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w').prop('ShapeProperty').set('shapeFunctionType', 'shlag');
model.physics('w').prop('ShapeProperty').set('order', '2');
model.physics('w2').prop('ShapeProperty').set('shapeFunctionType', 'shlag');
model.physics('w2').prop('ShapeProperty').set('order', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').set('testvnavg', '0.5*((test(up(vx))+test(down(vx)))*unx+(test(up(vy))+test(down(vy)))*uny)');

model.physics('w').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('w2').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.weak.remove('weak6');

model.field.remove('field3');

model.shape.remove('shape3');
model.shape.create('shape3', 'material1');
model.shape('shape3').valuetype('complex');
model.shape('shape3').feature.create('shfun1', 'shdisc');
model.shape('shape3').feature('shfun1').set('basename', 'comp1.p');
model.shape('shape3').feature('shfun1').set('order', 1);
model.shape('shape3').feature('shfun1').set('mdim', 2);

model.field.create('field3', 'p');
model.field('field3').shape({'shape3'});

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('eipsilon', '1');
model.param.set('sigma', '2');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('sigma', '1');
model.param.set('eipsilon', '-1');
model.param.remove('uin');
model.param.remove('umax');
model.param.remove('Re');
model.param.remove('D');
model.param.remove('umean');
model.param.remove('rho');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('w2').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.study('std1').feature('stat').set('showdistribute', true);

model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*nx');
model.physics('w').feature('ibweak2').set('weakExpression', 'nu*(sigma/h^beta)*vjump*testvjump-nu*vnavg*testvjump+nu*eipsilon*testvnavg*vjump+pavg*testvjump*ny');
model.physics('w').feature('init1').set('u', '1');
model.physics('w').feature('init1').set('v', '1');
model.physics('w2').feature('init1').set('p', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').run('v1');

model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg2').run;

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.label('Stokes_test1.mph');

model.physics.remove('w');
model.physics.remove('w2');
model.physics.create('w', 'WeakFormPDE', 'geom1', {'u'});

model.study('std1').feature('stat').activate('w', true);

model.physics('w').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_u']);
model.physics('w').feature('wfeq1').setIndex('weak', 'nu*(ux*test(ux)+uy*test(uy))-p*test(ux)-f1*test(u)', 0);
model.physics('w').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('w').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*nx');
model.physics('w').feature.create('weak1', 'WeakContribution', 1);
model.physics('w').feature.remove('weak1');
model.physics('w').feature.create('dir1', 'DirichletBoundary', 1);
model.physics('w').feature.remove('dir1');
model.physics('w').feature.create('weak1', 'WeakContribution', 1);
model.physics('w').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('w').feature.create('wfeq2', 'WeakFormPDE', 2);
model.physics('w').feature('wfeq2').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_v']);
model.physics('w').feature('wfeq2').setIndex('weak', 'nu*(vx*test(vx)+vy*test(vy))-p*test(vy)-f2*test(v)', 0);
model.physics('w').feature.create('ibweak2', 'InteriorBoundaryContribution', 2);
model.physics('w').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_u_v_p']);
model.physics('w').field('dimensionless').component({'u' 'u2'});
model.physics('w').field('dimensionless').component({'u' 'u2' 'u3'});
model.physics('w').field('dimensionless').component(2, 'v');
model.physics('w').field('dimensionless').component(3, 'p');
model.physics('w').feature('wfeq1').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_u']);
model.physics('w').feature('zflx1').label([native2unicode(hex2dec({'96' 'f6'}), 'unicode')  native2unicode(hex2dec({'90' '1a'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') '_u']);
model.physics('w').feature('init1').label([native2unicode(hex2dec({'52' '1d'}), 'unicode')  native2unicode(hex2dec({'59' 'cb'}), 'unicode')  native2unicode(hex2dec({'50' '3c'}), 'unicode') '_u']);
model.physics('w').feature('ibweak1').label([native2unicode(hex2dec({'7f' '51'}), 'unicode')  native2unicode(hex2dec({'68' '3c'}), 'unicode')  native2unicode(hex2dec({'8f' 'b9'}), 'unicode')  native2unicode(hex2dec({'75' '4c'}), 'unicode')  native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'8d' '21'}), 'unicode')  native2unicode(hex2dec({'73' '2e'}), 'unicode') '_u']);
model.physics('w').feature('weak1').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'8d' '21'}), 'unicode')  native2unicode(hex2dec({'73' '2e'}), 'unicode') '_u']);
model.physics('w').feature('ibweak2').label([native2unicode(hex2dec({'7f' '51'}), 'unicode')  native2unicode(hex2dec({'68' '3c'}), 'unicode')  native2unicode(hex2dec({'8f' 'b9'}), 'unicode')  native2unicode(hex2dec({'75' '4c'}), 'unicode')  native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'8d' '21'}), 'unicode')  native2unicode(hex2dec({'73' '2e'}), 'unicode') '_v']);
model.physics('w').feature.create('weak2', 'WeakContribution', 1);
model.physics('w').feature('weak2').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'8d' '21'}), 'unicode')  native2unicode(hex2dec({'73' '2e'}), 'unicode') '_v']);
model.physics('w').feature('weak2').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*g1-nu*sigma/h^beta*test(v)*g2');
model.physics('w').feature.create('wfeq3', 'WeakFormPDE', 2);
model.physics('w').feature('wfeq3').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_p']);
model.physics('w').feature('wfeq3').setIndex('weak', '-test(p)*(ux+vy)', 2);
model.physics.remove('w');
model.physics.create('w', 'WeakFormPDE', 'geom1', {'u'});

model.study('std1').feature('stat').activate('w', true);

model.physics.create('w2', 'WeakFormPDE', 'geom1', {'u2'});

model.study('std1').feature('stat').activate('w2', true);

model.physics.create('w3', 'WeakFormPDE', 'geom1', {'u3'});

model.study('std1').feature('stat').activate('w3', true);

model.physics('w').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_u']);
model.physics('w').tag('u');
model.physics('w2').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_v']);
model.physics('w2').tag('v');
model.physics('v').field('dimensionless').field('v');
model.physics('v').field('dimensionless').component(1, 'v');
model.physics('w3').label([native2unicode(hex2dec({'5f' '31'}), 'unicode')  native2unicode(hex2dec({'89' 'e3'}), 'unicode')  native2unicode(hex2dec({'57' '8b'}), 'unicode')  native2unicode(hex2dec({'50' '4f'}), 'unicode')  native2unicode(hex2dec({'5f' 'ae'}), 'unicode')  native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') '_p']);
model.physics('w3').tag('p');
model.physics('p').field('dimensionless').field('p');
model.physics('p').field('dimensionless').component(1, 'p');
model.physics('u').feature('wfeq1').setIndex('weak', 'nu*(ux*test(ux)+uy*test(uy))-p*test(ux)-f1*test(u)', 0);
model.physics('u').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('u').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*nx');
model.physics('u').feature.create('weak1', 'WeakContribution', 1);
model.physics('u').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*u*test(u)-nu*un*test(u)+nu*eipsilon*testun*u+p*test(u)*nx-nu*eipsilon*testun*g1-nu*sigma/h^beta*test(u)*g1');
model.physics('v').feature('wfeq1').setIndex('weak', 'nu*(vx*test(vx)+vy*test(vy))-p*test(vy)-f2*test(v)', 0);
model.physics('v').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('v').feature.create('weak1', 'WeakContribution', 1);
model.physics('v').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*vjump*testvjump-nu*vnavg*testvjump+nu*eipsilon*testvnavg*vjump+pavg*testvjump*ny');
model.physics('v').feature('weak1').set('weakExpression', 'nu*sigma/h^beta*v*test(v)-nu*vn*test(v)+nu*eipsilon*testvn*v+p*test(v)*ny-nu*eipsilon*testvn*g1-nu*sigma/h^beta*test(v)*g2');
model.physics('p').feature.create('ibweak1', 'InteriorBoundaryContribution', 2);
model.physics('p').feature.create('weak1', 'WeakContribution', 1);
model.physics('p').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)', 0);
model.physics('p').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*nx+vjump*ny)');
model.physics('p').feature('weak1').set('weakExpression', 'test(p)*(ux*nx+vy*ny)-test(p)*(g1*nx+g2*ny)');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('p').prop('ShapeProperty').set('order', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('u').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('p').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('eipsilon', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '3');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.mesh('mesh1').feature('size').set('custom', 'on');

model.physics('p').feature('wfeq1').setIndex('weak', '-test(p)*(ux+vy)+test(p)*p*1e-6', 0);

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '2');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').set('g1', '0');
model.variable('var1').set('g2', '0');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').set('un', 'ux*unx+uy*uny');
model.variable('var1').set('vn', 'vx*unx+vy*uny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.variable('var1').set('testun', 'test(ux)*unx+test(uy)*uny');
model.variable('var1').set('testvn', 'test(vx)*unx+test(vy)*uny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('eipsilon', '-1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '5');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('eipsilon', '0');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('eipsilon', '1');
model.param.set('sigma', '3');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').updateSolution;

model.result('pg1').run;

model.physics('p').feature('init1').set('p', '1');
model.physics('v').feature('init1').set('v', '1');
model.physics('u').feature('init1').set('u', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('beta', '1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('eipsilon', '-1');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('p').feature('init1').set('p', '0');
model.physics('v').feature('init1').set('v', '0');
model.physics('u').feature('init1').set('u', '0');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.label('Stokes_test1.mph');

model.physics('p').prop('ShapeProperty').set('shapeFunctionType', 'shlag');
model.physics('v').prop('ShapeProperty').set('shapeFunctionType', 'shlag');
model.physics('u').prop('ShapeProperty').set('shapeFunctionType', 'shlag');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.param.set('sigma', '10');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');

model.physics('u').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*ujump*testujump-nu*unavg*testujump+nu*eipsilon*testunavg*ujump+pavg*testujump*unx');
model.physics('v').feature('ibweak1').set('weakExpression', 'nu*(sigma/h^beta)*vjump*testvjump-nu*vnavg*testvjump+nu*eipsilon*testvnavg*vjump+pavg*testvjump*uny');

model.sol('sol1').study('std1');

model.study('std1').feature('stat').set('notlistsolnum', 1);
model.study('std1').feature('stat').set('notsolnum', '1');
model.study('std1').feature('stat').set('listsolnum', 1);
model.study('std1').feature('stat').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'stat');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'stat');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'dDef');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'spooles');
model.sol('sol1').feature('s1').feature('aDef').set('symmetric', 'off');
model.sol('sol1').feature('s1').feature('aDef').set('matrixformat', 'sparse');
model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('aDef').set('matrixformat', 'auto');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').updateSolution;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;

model.variable('var1').set('uerr', 'u-uexac');

model.sol('sol1').updateSolution;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'uerr');

model.sol('sol1').updateSolution;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'uexac');
model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'vexac');
model.result('pg2').run;

model.physics('p').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('v').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');
model.physics('u').prop('ShapeProperty').set('shapeFunctionType', 'shdisc');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').feature('s1').feature('dDef').set('linsolver', 'mumps');
model.sol('sol1').feature('s1').feature('aDef').set('symmetric', 'auto');

model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;

model.physics('u').feature('weak1').selection.all;
model.physics('v').feature('weak1').selection.all;
model.physics('u').feature('ibweak1').selection.all;
model.physics('v').feature('ibweak1').selection.all;
model.physics('p').feature('ibweak1').selection.all;
model.physics('p').feature('weak1').selection.all;

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'uerr');
model.result('pg1').run;

model.variable('var1').set('u_l2err', 'sqrt(intop1(uerr^2))');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u_l2err');
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.variable('var1').set('verr', 'v-vexac');
model.variable('var1').set('v_l2err', 'sqrt(intop1(verr^2))');

model.mesh('mesh1').run('size');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('size').set('hmin', '1/8');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').run;
model.mesh('mesh1').feature('conv1').active(false);
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run('size');
model.mesh('mesh1').feature('map1').active(false);
model.mesh('mesh1').run('map1');
model.mesh('mesh1').feature('size').set('custom', 'off');
model.mesh('mesh1').run('size');
model.mesh.remove('mesh1');
model.mesh.create('mesh1', 'geom1');
model.mesh('mesh1').automatic(false);
model.mesh('mesh1').feature('size').set('custom', 'on');
model.mesh('mesh1').feature('size').set('hmax', '1/8');
model.mesh('mesh1').create('map1', 'Map');
model.mesh('mesh1').feature('map1').set('adjustedgdistr', 'on');
model.mesh('mesh1').feature.remove('ftri1');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run('size');
model.mesh('mesh1').create('conv1', 'Convert');
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').run;
model.mesh('mesh1').run;
model.mesh('mesh1').run('conv1');
model.mesh('mesh1').run;
model.mesh('mesh1').run;
model.mesh('mesh1').run;
model.mesh('mesh1').feature.move('conv1', 2);
model.mesh('mesh1').feature('map1').selection.geom('geom1', 2);
model.mesh('mesh1').feature('map1').selection.set([1]);
model.mesh('mesh1').feature('map1').selection.all;
model.mesh('mesh1').run('map1');
model.mesh('mesh1').run;

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.param.set('sigma', '1');
model.param.set('eipsilon', '1');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').set('allowtableupdate', false);
model.result('pg1').set('title', [native2unicode(hex2dec({'88' '68'}), 'unicode')  native2unicode(hex2dec({'97' '62'}), 'unicode') ':']);
model.result('pg1').set('xlabel', '');
model.result('pg1').set('ylabel', '');
model.result('pg1').set('hasbeenplotted', true);
model.result('pg1').feature('surf1').set('rangeunit', '');
model.result('pg1').feature('surf1').set('rangecolormin', 0.035259086190874867);
model.result('pg1').feature('surf1').set('rangecolormax', 0.035259086190874867);
model.result('pg1').feature('surf1').set('rangecoloractive', 'off');
model.result('pg1').feature('surf1').set('rangedatamin', 0.035259086190874867);
model.result('pg1').feature('surf1').set('rangedatamax', 0.035259086190874867);
model.result('pg1').feature('surf1').set('rangedataactive', 'off');
model.result('pg1').feature('surf1').set('rangeactualminmax', [0.035259086190874867 0.035259086190874867]);
model.result('pg1').feature('surf1').set('hasbeenplotted', true);
model.result('pg1').set('renderdatacached', false);
model.result('pg1').set('allowtableupdate', true);
model.result('pg1').set('renderdatacached', true);
model.result.table('evl2').addRow([0.20361045002937317 0.5195295214653015 0.03525908619087487], [0 0 0]);
model.result.table('evl2').addRow([0.4931071400642395 0.30585336685180664 0.035259086190874867], [0 0 0]);
model.result.table('evl2').addRow([0.4218817949295044 0.41613784432411194 0.035259086190874867], [0 0 0]);

model.param.set('beta', '2');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'v');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'v_l2err');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'v');
model.result('pg2').run;
model.result('pg2').feature('surf1').create('hght1', 'Height');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('hght1').active(false);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'v_l2err');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').feature('hght1').active(true);
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'vexac');
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'v');
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').create('hght1', 'Height');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'uexac');
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u_l2err');
model.result('pg1').run;

model.param.set('beta', '1');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u');
model.result('pg1').run;

model.param.set('beta', '3');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'u_l2err');
model.result('pg1').run;

model.param.set('eipsilon', '-1');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '2');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('eipsilon', '1');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.param.set('eipsilon', '-1');
model.param.set('beta', '3');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('sigma', '10');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('sigma', '2');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '1');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '4');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '3');
model.param.set('sigma', '3');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('sigma', '5');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('uv_l2err', 'sqrt(intop1(uerr^2+verr^2))');

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').set('expr', 'uv_l2err');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('surf1').feature.remove('hght1');
model.result('pg2').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.result('pg1').run;
model.result('pg2').run;

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'uv_l2err');
model.result('pg1').run;

model.variable('var1').set('g1', 'uexac');
model.variable('var1').set('g2', 'vexac');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').feature.remove('hght1');
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '4');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.label('Stokes_test1.mph');

model.result('pg1').run;

model.param.set('sigma', '10');
model.param.set('beta', '1');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').set('allowtableupdate', false);
model.result('pg1').set('title', [native2unicode(hex2dec({'88' '68'}), 'unicode')  native2unicode(hex2dec({'97' '62'}), 'unicode') ':']);
model.result('pg1').set('xlabel', '');
model.result('pg1').set('ylabel', '');
model.result('pg1').set('hasbeenplotted', true);
model.result('pg1').feature('surf1').set('rangeunit', '');
model.result('pg1').feature('surf1').set('rangecolormin', 7.327397833474831E-4);
model.result('pg1').feature('surf1').set('rangecolormax', 7.327397833474831E-4);
model.result('pg1').feature('surf1').set('rangecoloractive', 'off');
model.result('pg1').feature('surf1').set('rangedatamin', 7.327397833474831E-4);
model.result('pg1').feature('surf1').set('rangedatamax', 7.327397833474831E-4);
model.result('pg1').feature('surf1').set('rangedataactive', 'off');
model.result('pg1').feature('surf1').set('rangeactualminmax', [7.327397833474831E-4 7.327397833474831E-4]);
model.result('pg1').feature('surf1').set('hasbeenplotted', true);
model.result('pg1').set('renderdatacached', false);
model.result('pg1').set('allowtableupdate', true);
model.result('pg1').set('renderdatacached', true);
model.result.table('evl2').addRow([0.9939822554588318 0.6068381071090698 7.327397833474831E-4], [0 0 0]);

model.param.set('beta', '3');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('uv_l2err', 'sqrt(u_l2err^2+v_l2err^2)');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.param.set('beta', '2');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '1');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '2');

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('eipsilon', '1');
model.param.set('beta', '1');

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('g1', '0');
model.variable('var1').set('g2', '0');

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '3');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');
model.mesh('mesh1').run;
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').run;
model.mesh('mesh2').create('ref1', 'Refine');
model.mesh('mesh2').run;
model.mesh('mesh2').feature('size').set('hauto', '9');
model.mesh('mesh2').run('size');
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh.remove('mesh2');
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').run;
model.mesh('mesh2').create('ref1', 'Refine');
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh('mesh2').feature('ref1').set('rmethod', 'longest');
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').run('ref1');
model.mesh('mesh2').run;
model.mesh('mesh2').feature.remove('ref1');
model.mesh('mesh2').feature('size').set('hmax', '0.033');
model.mesh('mesh2').run;
model.mesh('mesh2').feature('size').set('custom', 'off');
model.mesh('mesh2').feature('size').set('hauto', '4');
model.mesh('mesh2').run('size');
model.mesh('mesh2').run;
model.mesh('mesh2').run;
model.mesh('mesh2').run('size');
model.mesh('mesh2').run;
model.mesh('mesh2').run('size');
model.mesh('mesh2').run;
model.mesh('mesh2').run('size');
model.mesh('mesh2').run;
model.mesh.remove('mesh2');
model.mesh.create('mesh2', 'geom1');
model.mesh('mesh2').autoMeshSize(3);
model.mesh('mesh2').run;

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);
model.study('std1').feature('stat').set('geomselection', 'geom1');
model.study('std1').feature('stat').set('mesh', {'geom1' 'mesh2'});

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh2').autoMeshSize(4);
model.mesh('mesh2').run;
model.mesh('mesh2').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh2').autoMeshSize(3);
model.mesh('mesh2').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh2').autoMeshSize(4);
model.mesh('mesh2').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('beta', '1');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh2').autoMeshSize(3);
model.mesh('mesh2').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh2').autoMeshSize(5);
model.mesh('mesh2').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('testun', 'test(ux)*nx+test(uy)*ny');
model.variable('var1').set('testvn', 'test(vx)*nx+test(vy)*ny');
model.variable('var1').set('un', 'ux*nx+uy*ny');
model.variable('var1').set('vn', 'vx*nx+vy*ny');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);
model.study('std1').feature('stat').set('geomselection', 'geom1');
model.study('std1').feature('stat').set('mesh', {'geom1' 'mesh1'});

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('eipsilon', '-1');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('g1', 'uexac');
model.variable('var1').set('g2', 'vexac');

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('testunavg', '0.5*((test(up(ux))+test(down(ux)))*nx+(test(up(uy))+test(down(uy)))*ny)');
model.variable('var1').set('testvnavg', '0.5*((test(up(vx))+test(down(vx)))*nx+(test(up(vy))+test(down(vy)))*ny)');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('unavg', '0.5*((up(ux)+down(ux))*nx+(up(uy)+down(uy))*ny)');
model.variable('var1').set('vnavg', '0.5*((up(vx)+down(vx))*nx+(up(vy)+down(vy))*ny)');

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('g1', '0');
model.variable('var1').set('g2', '0');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.param.set('eipsilon', '1');

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.variable('var1').set('unavg', '0.5*((up(ux)+down(ux))*unx+(up(uy)+down(uy))*uny)');
model.variable('var1').set('vnavg', '0.5*((up(vx)+down(vx))*unx+(up(vy)+down(vy))*uny)');
model.variable('var1').set('testunavg', '0.5*((test(up(ux))+test(down(ux)))*unx+(test(up(uy))+test(down(uy)))*uny)');
model.variable('var1').set('testvnavg', '0.5*((test(up(vx))+test(down(vx)))*unx+(test(up(vy))+test(down(vy)))*uny)');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.label('Stokes_update1.mph');

model.result('pg1').run;

model.physics('p').feature('weak1').set('weakExpression', 'test(p)*(u*nx+v*ny)-test(p)*(g1*nx+g2*ny)');

model.param.set('eipsilon', '-1');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');
model.mesh('mesh1').run('size');
model.mesh('mesh1').run;

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'p');
model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.physics('p').feature('ibweak1').set('weakExpression', 'testpavg*(ujump*unx+vjump*uny)');

model.mesh('mesh1').feature('size').set('hmax', '1/64');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;
model.result('pg1').feature('surf1').set('expr', 'uv_l2err');
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/32');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/16');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/8');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.mesh('mesh1').feature('size').set('hmax', '1/4');

model.study('std1').feature('stat').set('showdistribute', true);

model.sol('sol1').runAll;

model.result('pg1').run;

model.label('Stokes_update1.mph');

model.result('pg1').run;

model.physics.create('w', 'WeakFormPDE', 'geom1', {'u2'});

model.study('std1').feature('stat').activate('w', true);

model.physics('w').label('to_test');

out = model;
